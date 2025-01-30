class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  # Validations
  validates :quantity, numericality: { greater_than: 0 }
end
