class SuppliersController < ApplicationController
  before_action :authenticate_user!

  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end
end
