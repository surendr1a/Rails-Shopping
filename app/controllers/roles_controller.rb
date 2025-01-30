class RolesController < ApplicationController
  before_action :authenticate_user!

  def index
    @roles = Role.all
  end

  def show
    @role = Role.find(params[:id])
  end
end
