class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart.build(cart_params)
    @product = Product.find(params[:product_id])

    @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
    @cart_item.quantity += 1

    if @cart_item.save
      redirect_to cart_path(@cart.id), notice: 'Item added to your cart!'
    else
      redirect_to cart_path(@cart), alert: 'Error adding item to cart.'
    end
  end

  def destroy
    @cart_item = current_user.cart.cart_items.find(params[:id])
    if @cart_item.destroy
      redirect_to cart_path(current_user.cart), notice: 'Item removed from your cart.'
    else
      redirect_to cart_path(current_user.cart), alert: 'Error removing item from cart.'
    end
  end
end
