class ProductReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:create]

  def create
    @review = @product.product_reviews.build(product_review_params)
    @review.user = current_user
    if @review.save
      redirect_to @product, notice: 'Review added successfully.'
    else
      redirect_to @product, alert: 'Error adding review.'
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def product_review_params
    params.require(:product_review).permit(:rating, :comment)
  end
end
