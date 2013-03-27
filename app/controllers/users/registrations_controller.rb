class Users::RegistrationsController < Devise::RegistrationsController
  require 'net/http/post/multipart'
  def create
    build_resource

    if resource.save
     set_flash_message :notice, :signed_up
     sign_in(resource_name, resource)
     if resource.photo.content_type == "image/png" || resource.photo.content_type == "image/jpeg"
      if resource.photo.tempfile.size >= 1048576
        resource.photo = nil
      else
        token = resource.mediafire_token
        uri = "http://www.mediafire.com/api/upload/upload.php?session_token="+ token +"&response_format=json&uploadkey=w6chdwp01mada"
        res = resource.upload_file(uri, resource.photo.tempfile)
        key = resource.get_quick_key(res, token, resource)
        p "SIZE: " + resource.photo.tempfile.size
        p "Contenido: " + resource.photo.content_type
        resource.photo = key
      end
    else
      resource.photo = nil
    end
     redirect_to root_path
    else
      render action: "new"
    end
  end

end