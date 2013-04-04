class ContactInfosController < ApplicationController
  before_filter :authenticate_user!
  def new
    unless current_user.market.contact_info
      @contact_info = ContactInfo.new
      @market = current_user.market
      @payment_info = PaymentInfo.new
      @fb_authentication = Authentication.find_by_provider_and_user_id('facebook', @user.id.to_s)
      @twitter_authentication = Authentication.find_by_provider_and_user_id('twitter', @user.id.to_s)
      @google_authentication = Authentication.find_by_provider_and_user_id('google_oauth2', @user.id.to_s)
      @screen_name = @user.twitter_screen_name if @twitter_authentication
      @fb_groups = current_user.fb_groups if @fb_authentication
    else
      redirect_to edit_market_contact_info_path(@market, @market.contact_info)
    end
  end

  def create
    @twitter_authentication = Authentication.find_by_provider_and_user_id('twitter', @user.id.to_s)
    @google_authentication = Authentication.find_by_provider_and_user_id('google_oauth2', @user.id.to_s)
    @screen_name = @user.twitter_screen_name if @twitter_authentication
    @contact_info = ContactInfo.new(params[:contact_info])
    @contact_info.market = current_user.market
    @contact_info.google_plus = current_user.google_info['url'] if @google_authentication
    @contact_info.twitter = @screen_name if @twitter_authentication
    if @contact_info.save
      redirect_to markets_path
    else
      render action: "new", alert: "Ocurrieron errores al guardar tus datos"
    end
  end

  def edit
    @contact_info = ContactInfo.find(params[:id])
    @market = Market.find(params[:market_id])
    @fb_groups = current_user.fb_groups
    @fb_authentication = Authentication.find_by_provider_and_user_id('facebook', @user.id.to_s)
    @twitter_authentication = Authentication.find_by_provider_and_user_id('twitter', @user.id.to_s)
    @google_authentication = Authentication.find_by_provider_and_user_id('google_oauth2', @user.id.to_s)
    @screen_name = @user.twitter_screen_name if @twitter_authentication
  end

  def update
    @contact_info = ContactInfo.find(params[:id])
    @google_authentication = Authentication.find_by_provider_and_user_id('google_oauth2', @user.id.to_s)
    @contact_info.google_plus = current_user.google_info['url'] if @google_authentication
      if @contact_info.update_attributes(params[:contact_info])
        redirect_to markets_path, notice: 'Datos de Contacto Actualizados.'
      else
        render action: "edit"
      end
  end

end
