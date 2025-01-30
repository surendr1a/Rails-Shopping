class InventoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
  end
end
