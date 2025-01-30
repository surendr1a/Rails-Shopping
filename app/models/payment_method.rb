class PaymentMethod < ApplicationRecord
  belongs_to :user

  # Validations
  validates :method_type, presence: true
end
