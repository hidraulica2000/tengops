class AuthenticationsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    p auth
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
    #@market = current_user.market
    #if authentication
    #  flash[:notice] = "Cuenta conectada."
    #  unless @market.contact_info.present?
    #    redirect_to new_market_contact_info_path(@market)
    #  else
    #    redirect_to edit_market_contact_info_path(@market, @market.contact_info)
    #  end
    #else
      current_user.apply_omniauth(auth)
      flash[:notice] = "Cuenta conectada."
      redirect_to root_path
    #  if current_user.save(:validate => false)
    #    provider = auth['provider']
    #    if provider == 'google_oauth2'
    #      provider = 'Google Plus'
    #    end
    #    flash[:notice] = provider.capitalize + " ha sido conectado a tu cuenta"
    #    unless @market.contact_info.present?
    #      redirect_to new_market_contact_info_path(@market)
    #    else
    #      redirect_to edit_market_contact_info_path(@market, @market.contact_info)
    #    end
    #  else
    #    flash[:alert] = "Tu cuenta de Facebook no pudo ser conectada."
    #    redirect_to markets_path
    #  end
    #end
  end

  def recreate
    authentication = Authentication.find(params[:id])
    authentication.destroy
    @market = current_user.market
    @market.contact_info.update_attributes(:google_plus => "''")
    redirect_to '/auth/google_oauth2?approval_prompt=force'
  end
end
