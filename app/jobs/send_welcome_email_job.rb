class SendWelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user, order)
    UserMailer.order_confirmation_email(user, order).deliver_now
  end
end
