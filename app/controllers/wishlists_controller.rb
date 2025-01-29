class WishlistsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_wishlist, only: [:show, :add_item, :remove_item]

  def show
  end

  def add_item
    @wishlist.add_product(params[:product_id])
    redirect_to @wishlist, notice: 'Item added to wishlist!'
  end

  def remove_item
    @wishlist.remove_product(params[:product_id])
    redirect_to @wishlist, notice: 'Item removed from wishlist!'
  end

  private

  def set_wishlist
    @wishlist = current_user.wishlist || current_user.create_wishlist
  end
end
