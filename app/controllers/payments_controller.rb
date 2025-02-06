class PaymentsController < ApplicationController
  def create
    @order = Razorpay::Order.create(
      amount: 50000,  
      currency: 'INR',
      payment_capture: 1
    )
    @order_id = @order['id']
    render json: { order_id: @order_id }
  end
  def verify
    payment_id = params[:payment_id]
    order_id = params[:order_id]
    signature = params[:signature]

    # Verify signature
    payload = order_id + "|" + payment_id
    if Razorpay::Utility.verify_payment_signature(payload, signature)
      
      render json: { success: true }
    else
      render json: { success: false, message: 'Signature mismatch' }
    end
  end
end
