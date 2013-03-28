class Users::RegistrationsController < Devise::RegistrationsController
  require 'net/http/post/multipart'
  def create
    build_resource

    if resource.save
     set_flash_message :notice, :signed_up
     sign_in(resource_name, resource)
     redirect_to root_path
    else
      render action: "new"
    end
  end

end