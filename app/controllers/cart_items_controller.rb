class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @cart = current_user.cart
    @product = Product.find(params[:product_id])

    @Cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
    @cart_item.quantity +=1
    @cart_item.save

    redirect_to_cart_path
  end

  def destroy
   @Cart_item = current_user.Cart.cart_item.find(params[:id])
   @cart_item.destroy

   redirect_to_cart_path
  end
end

