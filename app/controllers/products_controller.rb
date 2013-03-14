class ProductsController < ApplicationController
  def index
    @games = Game.search(params[:search])
  end

  def new
  end

  def create
  end

  def show
  end

  def destroy
  end

  def edit
  end
end
