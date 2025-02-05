class CartsController < ApplicationController
  before_action :set_cart

  def index
    @cart_items = @cart.cart_items
  end

  def create
    @product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if @cart.add_product(@product.id, quantity)
      redirect_to cart_path(@cart.id), notice: 'Product added to your cart!'
    else
      redirect_to products_path, alert: 'Error adding product to cart.'
    end
  end

  def show
   @cart = Cart.find_by(id: params[:id])
    @cart_items = @cart.cart_items
  end

  def add_item
    @product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if @cart.add_product(@product.id, quantity)
      redirect_to cart_path(@cart.id), notice: 'Item added to your cart!'
    else
      redirect_to cart_path, alert: 'Error adding item.'
    end
  end
  
  def remove_item
    
    @cart_item = @cart.cart_items.find(params[:cart_item_id])  
    @cart_item.destroy  
    redirect_to cart_path(@cart), notice: 'Item removed from your cart.'
  end

  def update_item
    @product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if @cart.update_product_quantity(@product.id, quantity)
      redirect_to cart_path(@cart.id), notice: 'Cart updated!'
    else
      redirect_to cart_path, alert: 'Error updating cart.'
    end
  end

  private

  def set_cart
    if current_user
      @cart = current_user.cart || current_user.create_cart
    else
      redirect_to new_user_session_path, alert: "Please log in to access your cart."
    end
  end
end
