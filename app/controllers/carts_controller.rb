class CartsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_cart, only: [:index, :show, :add_item, :remove_item, :update_item]

  def index
    @cart_items = CartItem.all  # Ensure you get cart items here
  end

  def show
    # @cart is already set by before_action
    @cart_items = @cart.cart_items.includes(:product)  # Get cart items associated with the cart
  end

  def add_item
    if @cart.add_item(params[:product_id])
      redirect_to @cart, notice: 'Item added to your cart!'
    else
      redirect_to @cart, alert: 'Error adding item.'
    end
  end

  def remove_item
    if @cart.remove_item(params[:product_id])
      redirect_to @cart, notice: 'Item removed from your cart.'
    else
      redirect_to @cart, alert: 'Error removing item.'
    end
  end

  def update_item
    if @cart.update_item(params[:product_id], params[:quantity])
      redirect_to @cart, notice: 'Cart updated!'
    else
      redirect_to @cart, alert: 'Error updating cart.'
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
