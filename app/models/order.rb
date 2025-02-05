class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  # byebug
  validates :status, presence: true, inclusion: { in: %w[pending completed cancelled] }
  # after_create_commit :order_confirmation_email

  # private

  # def order_confirmation_email
    # byebug
    # UserMailer.with(self.user, self).order_confirmation_email.deliver_now
    # UserMailer.order_confirmation_email(@user, @order).deliver_now
  # end
end
