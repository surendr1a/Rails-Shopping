class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    
    total_amount = 1000 

    payment_intent = Stripe::PaymentIntent.create(
      
      amount: total_amount,
      currency: 'INR',
      payment_method_types: ['card']
    )

    redirect_to payment_intent.next_action.use_stripe_sdk.stripe_js, allow_other_host: true if payment_intent.next_action
  end
end
