class WishlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wishlist, only: [:show, :add_item, :remove_item]

  def show
  end

  def add_item
    if @wishlist.add_product(params[:product_id])
      redirect_to @wishlist, notice: 'Item added to wishlist!'
    else
      redirect_to @wishlist, alert: 'Error adding item.'
    end
  end

  def remove_item
    if @wishlist.remove_product(params[:product_id])
      redirect_to @wishlist, notice: 'Item removed from wishlist.'
    else
      redirect_to @wishlist, alert: 'Error removing item.'
    end
  end

  private

  def set_wishlist
    @wishlist = current_user.wishlist || current_user.create_wishlist
  end
end
