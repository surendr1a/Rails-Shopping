class UsersController < ApplicationController
  # byebug
  before_action :authenticate_user!, only: [:show]

  def index
    @users = User.all
  end

  def show
    # @user = User.find(params[:id])
      @user = current_user
  end
end
