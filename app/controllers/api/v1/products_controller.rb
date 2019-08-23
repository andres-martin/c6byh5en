class Api::V1::ProductsController < ApplicationController
  # before_filter :find_product, only: [:update, :destroy]
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
    product = Product.find(params[:id])
    if product.update(product_params)
      json_response(product, 200)      
    else
      json_response(product.errors, 422)
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    render status: 204
  end

  private
    def product_params
      params.require(:product).permit(:name, :price)
      # params.permit(:name, :price)
    end

    def find_product
      @product = Product.find(params[:id])
    end
end
