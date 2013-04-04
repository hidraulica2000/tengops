class MarketsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @user = current_user
    @fb_authentication = Authentication.find_by_provider_and_user_id('facebook', @user.id.to_s)
    @twitter_authentication = Authentication.find_by_provider_and_user_id('twitter', @user.id.to_s)
    @google_authentication = Authentication.find_by_provider_and_user_id('google_oauth2', @user.id.to_s)
    if @twitter_authentication
      @screen_name = @user.twitter_screen_name
    end
    if @fb_authentication
      @fb_picture = @user.fb_profile_picture
    end
    if @user.market.present?
      @market = @user.market
      @products = @user.market.products
    else
      redirect_to new_market_path
    end
  end

  def show
  end

  def new
    @user = current_user
    if @user.market.present?
      redirect_to markets_path(@user)
    else
      @market = Market.new
      @cities = Country.first.cities
    end

  end

  def create
    @market = Market.new(params[:market])
    @market.user = current_user
    @market.country_id = Country.first.id
    if @market.save
      redirect_to markets_path(current_user), :notice => "Market creado satisfactioriamente"
    else
      redirect_to root_path, :alert => "Market no ha sido creado"
    end
  end
end
