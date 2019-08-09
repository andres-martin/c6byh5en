class Api::V1::ProductsController < ApplicationController
  include Response

  def index
    @products = Product.all
    render json: @products
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      json_response(@product, 201) 
    else
      json_response(@product.errors, 422)
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.update(params[:id], product_params)
  end

  private
    def product_params
      params.require(:product).permit(:name, :price)
      # params.permit(:name, :price)
    end
end
