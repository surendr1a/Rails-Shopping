class UserMailer < ApplicationMailer
  def order_confirmation_email(user, order)
  # byebug
  # @user = params[:user]
    @user = user
    @order = order
    mail(to: @user.email, subject: "Order Confirmation - ##{@order.id}") do |format|
      format.html
      format.text
    end
  end
#   def after_sign_email(user)
#     mail(to: @user.email, subject: "Successfully Registered - ##{@user.id}") do |format|
#     format.html
#     format.text 
#   end
# end
end
