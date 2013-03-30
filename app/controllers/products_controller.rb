class ProductsController < ApplicationController
  def index
    @games = Game.search(params[:search])
  end

  def new
    @game = Game.find(params[:game])
    if @game.boxart.length >= 20
      @cover = @game.boxart_normal
    else
      @cover = ApplicationController.helpers.get_link(@game.boxart_normal)
    end
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    @product.market = current_user.market
    @product.game = Game.find(params[:game].to_i)
    @game = Game.find(params[:game])
    if @product.save
      redirect_to markets_path
    else
      render action: "new", alert: "Ocurrieron errores al guardar el producto."
    end
  end

  def show
  end

  def destroy
    @product = Product.find(params[:id])
    @products = current_user.market.products
    @product.destroy
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
