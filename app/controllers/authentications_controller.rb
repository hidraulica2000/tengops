class AuthenticationsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

    if authentication
      flash[:notice] = "Cuenta de Facebook conectada."
      redirect_to markets_path(current_user)
    else
      current_user.apply_omniauth(auth)
      if current_user.save(:validate => false)
        flash[:notice] = "Cuenta conectada por primera vez"
        redirect_to markets_path(current_user)
      else
        flash[:alert] = "Tu cuenta de Facebook no pudo ser conectada."
        redirect_to markets_path(current_user)
      end
    end
  end
end
