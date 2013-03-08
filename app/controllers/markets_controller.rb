class MarketsController < ApplicationController

  def index
    @user = User.find(params[:user])
    if
    @market = @user.market
  end

  def show
  end

  def new
  end

  def create
  end
end
