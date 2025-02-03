class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def create
    cart_items = current_user.cart.cart_items
    return redirect_to carts_path, alert: "Your cart is empty" if cart_items.empty?

    ActiveRecord::Base.transaction do
      @order = current_user.orders.create!(
        total_price: cart_items.sum { |item| item.quantity * item.product.price },
        status: "completed"
      )

      cart_items.each do |item|
        @order.order_items.create!(
          product_id: item.product_id,
          quantity: item.quantity,
          price: item.product.price,
          total_price: item.quantity * item.product.price
        )
      end

      cart_items.destroy_all
    end

    redirect_to orders_path, notice: "Order placed successfully!"
  rescue => e
    redirect_to carts_path, alert: "Order failed: #{e.message}"
  end
end
