class ProductsController < ApplicationController
  def index
    @games = Game.search(params[:search])
  end

  def new
    @product = Product.new
    @game = Game.find(params[:game])
  end

  def create
    @product = Product.new(params[:product])
    @product.market = current_user.market
    @product.game = Game.find(params[:game].to_i)
    if @product.save
      redirect_to markets_path
    end
  end

  def show
  end

  def destroy
  end

  def edit
  end
end
