class OrdersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    @orders = current_user.orders
  end

  def show
  end

  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      redirect_to @order, notice: 'Order placed successfully!'
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully canceled.'
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :total_amount, :shipping_address)
  end
end
