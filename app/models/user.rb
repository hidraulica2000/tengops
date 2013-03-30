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

  def apply_omniauth(auth)
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end

  def fb_profile_picture
    fb_authentication = Authentication.find_by_provider_and_user_id('facebook', self.id.to_s)
    token = fb_authentication.token
    picture = "https://graph.facebook.com/me/picture?access_token=#{token}&width=200&height=200"
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
