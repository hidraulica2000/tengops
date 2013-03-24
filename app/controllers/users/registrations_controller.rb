class Users::RegistrationsController < Devise::RegistrationsController
  require 'net/http/post/multipart'
  def create
    build_resource
    token = resource.mediafire_token
    uri = "http://www.mediafire.com/api/upload/upload.php?session_token="+ token +"&response_format=json&uploadkey=w6chdwp01mada"
    res = resource.upload_file(uri, resource.photo.tempfile)
    link = resource.get_download_link(res, token, resource)

    resource.photo = link
    if resource.save
     set_flash_message :notice, :signed_up
     sign_in(resource_name, resource)
     redirect_to root_path
      #this commented line is responsible for sign in and redirection
      #change to something you want..
    else
      render action: "new"
    end
  end

end