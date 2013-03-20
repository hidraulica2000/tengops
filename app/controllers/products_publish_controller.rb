class ProductsPublishController < ApplicationController
  def update
    @product = Product.find(params[:product_id])
    @product.published = @product.published? ? false : true
    @product.save
    redirect_to markets_path
  end
end
