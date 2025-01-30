class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # Validations
  validates :quantity, numericality: { greater_than: 0 }
end
