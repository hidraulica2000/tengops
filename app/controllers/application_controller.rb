class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_cache_buster
  before_filter :client
  def client
    if user_signed_in?
      @user = User.find_by_id(params[:id]) || current_user
    end
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  #def after_sign_in_path_for(resource)
   # profile_path(resource) unless resource.class.to_s == "AdminUser"
  #end

end
