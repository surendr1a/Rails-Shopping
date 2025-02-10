class PaymentsController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in

  def create
    cart = Cart.find_by(user_id: current_user.id, status: "pending") # Active cart lo
    unless cart
      redirect_to root_url, alert: "Cart is empty!" and return
    end

    cart_items = cart.cart_items.includes(:product) # Cart ke products lo
    total_amount = cart_items.sum { |item| item.product.price * 100 } # Total price cents me

    # Create Stripe customer
    customer = Stripe::Customer.create(
      name: current_user.name,
      email: current_user.email,
      description: "Customer ID: #{current_user.id}"
    )

    # Stripe Checkout Session
    session = Stripe::Checkout::Session.create(
      customer: customer.id,
      payment_method_types: ['card'],
      line_items: cart_items.map do |item|
        {
          price_data: {
            currency: 'usd',
            product_data: {
              name: item.product.name,
              description: item.product.description
            },
            unit_amount: (item.product.price * 100).to_i
          },
          quantity: 1
        }
      end,
      mode: 'payment',
      success_url: success_payments_url(cart_id: cart.id),
      cancel_url: cancel_payments_url(cart_id: cart.id)
    )

    redirect_to session.url, allow_other_host: true
  end

  def success
    cart = Cart.find(params[:cart_id])
    order = Order.create(user: cart.user, status: "paid") # Order create karo
    cart.cart_items.each do |item|
      order.order_items.create(product: item.product, quantity: 1)
    end

    cart.update(status: "completed") # Cart empty kar do
    redirect_to root_url, notice: "Payment successful! Order ##{order.id} created."
  end

  def cancel
    redirect_to root_url, alert: "Payment was canceled."
  end
end
