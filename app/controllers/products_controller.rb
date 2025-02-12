class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_cart

  def index
    @q = Product.ransack(params[:q])
    # @pradi = @q.result(distinct: true)
    @products = @q.result(distinct: true)

    # @products = @pradi.result.page(params[:page]).per(2)
    # @products = @q.result.page(params[:page]).per(1)
    # @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    if @product.nil?
      redirect_to products_path, alert: "Product not found."
    end
  end

  def new
    
    @product = Product.new
  end

  def create
    
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to dashboard_path, notice: 'Product created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to dashboard_path, notice: 'Product updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product
      @product.destroy
      redirect_to dashboard_path, notice: 'Product deleted successfully.'
    else
      redirect_to dashboard_path, alert: 'Product not found.'
    end
  end
  

  private

  def set_product
    
    @product = Product.find(params[:id])
  end

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
  def product_params
    params.require(:product).permit(:name, :description, :price, :user_id, :inventory_id, :category_id, :stock_quantity, :sku, :weight, :brand, :color, :is_active, :image, :quantity)
  end
end
