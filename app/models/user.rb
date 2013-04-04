class User < ActiveRecord::Base
  require "net/http"
  require "uri"
  require 'open-uri'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :gamertag, :birth_date, :email, :password, :password_confirmation, :remember_me, :photo
  # attr_accessible :title, :body
  validates_presence_of :first_name, :last_name
  validate :check_gamertag, :before => :create
  validates_uniqueness_of :gamertag
  belongs_to :cover
  has_many :commentts
  has_one :market
  has_many :authentications, :dependent => :delete_all
  make_flagger

  def google_info
    authentication = Authentication.find_by_provider_and_user_id('google_oauth2',self.id)
    id = authentication.uid
    token = google_token(authentication.token)
    person = GooglePlus::Person.get(id, :access_token => token).attributes
  end

  def google_token refresh_token
    client_id = '595769821015.apps.googleusercontent.com'
    client_secret = 'LgHWFxdZYNf-qN19BvuXZn6Z'
    request = RestClient.post 'https://accounts.google.com/o/oauth2/token',
    :refresh_token => refresh_token, :client_id => client_id, :client_secret => client_secret, :grant_type => "refresh_token"
    token = JSON.parse(request)['access_token']
  end

  def apply_omniauth(auth)
    token_string = auth['provider'] == 'google_oauth2' ? 'refresh_token' : 'token'
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials'][token_string])
  end

  def apply_omniauth_twitter(auth)
    authentications.build(:provider => auth['provider'], :uid => auth['uid'])
  end

  def twitter_screen_name
    twitter_authentication = Authentication.find_by_provider_and_user_id('twitter', self.id.to_s)
    uri = 'https://api.twitter.com/1/users/show.json?user_id='+ twitter_authentication.uid
    json = RestClient.get uri
    screen_name = JSON.parse(json)["screen_name"]
  end

  def fb_profile_picture
    token = self.fb_token
    uri = "https://graph.facebook.com/me/picture?access_token=#{token}&width=200&height=200&timestamp=#{Time.now.to_time.to_i}"
  end

  def fb_token
    fb_authentication = Authentication.find_by_provider_and_user_id('facebook', self.id.to_s)
    token = fb_authentication.token
  end

  def fb_albums
    albums = RestClient.get 'https://graph.facebook.com/me/albums?access_token=' + self.fb_token
    JSON.parse(albums)
  end

  def fb_album_cover id
    cover = RestClient.get "https://graph.facebook.com/#{id}?access_token=#{self.fb_token}"
    JSON.parse(cover)['picture']
  end

  def fb_groups
    fb_authentication = Authentication.find_by_provider_and_user_id('facebook', self.id.to_s)
    token = fb_authentication.token
    uri = "https://graph.facebook.com/me?fields=id,groups,accounts&access_token=#{token}"
    json = RestClient.get uri
    data = JSON.parse(json)["groups"]["data"]
    id = JSON.parse(json)["id"]
    data << {"name"=>"Mi Perfil", "version"=>1, "id"=> id}
  end

  def full_name
  	first_name + " " + last_name
  end

  def get_avatar
    client = PsnTrophies::Client.new
    client.get_avatar(self.gamertag)
  end

  def trophies
    client = PsnTrophies::Client.new
    client.trophies_count(self.gamertag).first
  end

  def check_gamertag
    client = PsnTrophies::Client.new
    begin
      avatar = client.get_avatar(self.gamertag)
    rescue
      errors.add(:gamertag,'Verifica tu PSN id, el sistema no pudo encontrarlo')
    end
  end

  def get_friends
    string = ""
    int = 0
    User.all.each do |user|
      unless int == 0
        string.concat(",")
      end
      string.concat("{username: '#{user.gamertag}', name: '#{user.full_name}', image: '#{user.avatar}'}")
      unless int < User.all.count
        string.concat(",")
      end
      int += 1
    end
    return string
  end

  def mediafire_token
    app_id = Settings.storage.mediafire.app_id
    email = Settings.storage.mediafire.email
    password = Settings.storage.mediafire.password
    signature = Settings.storage.mediafire.signature
    uri = 'http://www.mediafire.com/api/user/get_session_token.php?email=' + email + '&password='+ password +'&application_id='+ app_id +'&signature='+ signature +'&response_format=json'
    uri = URI.parse(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    body = response.body
    json = JSON.parse(body)["response"]["session_token"]
  end

  def upload_file(uri,file)
    RestClient.post uri, :file => File.new(file, 'rb')
  end
    handle_asynchronously :upload_file

  def rename_file(quickkey, token, filename)
    RestClient.post 'http://www.mediafire.com/api/file/update.php', :session_token => token, :quick_key => quickkey, :filename => filename
  end
    handle_asynchronously :rename_file

  def get_quick_key(res, token, resource)
    key = JSON.parse(res.body)["response"]["doupload"]["key"]
    (1..20).each do |a|
      req = RestClient.get "http://www.mediafire.com/api/upload/poll_upload.php?session_token=" + token + "&key=" + key + "&response_format=json"
      quickkey = JSON.parse(req.body)["response"]["doupload"]["quickkey"]
      p quickkey
      if JSON.parse(req.body)["response"]["doupload"]["status"] == "99"
        download_link = RestClient.get "http://www.mediafire.com/api/file/get_links.php", {:params => {:session_token => token, :quick_key => quickkey, :response_format => 'json'}}
        resource.rename_file(quickkey, token, "#{resource.gamertag}_#{resource.photo.original_filename}")
        download_link = JSON.parse(download_link)["response"]["links"][0]["direct_download"]
        return quickkey
        break
      end
      sleep(2)
    end
  end
  handle_asynchronously :get_quick_key
end
