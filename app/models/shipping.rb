class Shipping < ApplicationRecord
  belongs_to :order

  # Validations
  validates :shipping_address, presence: true
  validates :shipping_method, presence: true
end
