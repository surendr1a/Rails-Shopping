class DiscountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @discounts = Discount.all
  end

  def show
    @discount = Discount.find(params[:id])
  end
end
