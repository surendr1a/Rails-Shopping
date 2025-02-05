class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def create
    # byebug
    cart_items = current_user.cart.cart_items
    return redirect_to carts_path, alert: "Your cart is empty" if cart_items.empty?

    ActiveRecord::Base.transaction do
      @order = current_user.orders.create!(
        total_price: cart_items.sum { |item| item.quantity * item.product.price },
        status: "completed"
      )

      cart_items.each do |item|
        product = item.product

        if product.stock_quantity < item.quantity
          raise StandardError, "Not enough stock for #{product.name}"
        end

        product.update!(stock_quantity: product.stock_quantity - item.quantity)

        @order.order_items.create!(
          product_id: item.product_id,
          quantity: item.quantity,
          price: item.product.price,
          total_price: item.quantity * item.product.price
        )

      end

      cart_items.destroy_all
    # UserMailer.order_confirmation_email(current_user, @order).deliver_now

    end
  # byebug 
    # UserMailer.order_confirmation_email(current_user, @order).deliver_now

    redirect_to orders_path, notice: "Order placed successfully!"

  rescue StandardError => e
    # flash[:alert] = "sorry you can't purchase order because it's stock is empty."
    redirect_to carts_path, alert: "Order failed: #{e.message}"
  end
end
