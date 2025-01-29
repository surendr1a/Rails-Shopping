class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_item, :remove_item, :update_item]

  def show
    @cart = current_user.cart 
  end

  def add_item
    @cart.add_item(params[:product_id])
    redirect_to @cart, notice: 'Item added to your cart!'
  end

  def remove_item
    @cart.remove_item(params[:product_id])
    redirect_to @cart, notice: 'Item removed from your cart!'
  end

  def update_item
    @cart.update_item(params[:product_id], params[:quantity])
    redirect_to @cart, notice: 'Cart updated!'
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
