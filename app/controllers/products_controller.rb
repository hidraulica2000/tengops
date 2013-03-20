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
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to markets_path, alert: 'Producto Eliminado'
  end

  def edit
    @product = Product.find(params[:id])
    @game = Game.find(params[:game])
  end

  def update
    @product = Product.find(params[:id])
      if @product.update_attributes(params[:product])
        redirect_to markets_path, notice: 'Producto Actualizado.'
      else
        render action: "edit"
      end
  end
end
