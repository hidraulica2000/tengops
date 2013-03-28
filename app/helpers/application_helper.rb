module ApplicationHelper
  include Twitter::Extractor
  include Twitter::Autolink
  def get_link quickkey
    token = User.first.mediafire_token
    download_link = RestClient.get "http://www.mediafire.com/api/file/get_links.php", {:params => {:session_token => token, :quick_key => quickkey, :response_format => 'json'}}
    download_link = JSON.parse(download_link)["response"]["links"][0]["direct_download"]
  end
end
