class UserMailer < ApplicationMailer
  def order_confirmation_email(user, order)
  # byebug
    @user = user
    # @user = params[:user]
    @order = order
    mail(to: @user.email, subject: "Order Confirmation - ##{@order.id}") do |format|
      format.html
      format.text
    end
  end
end
