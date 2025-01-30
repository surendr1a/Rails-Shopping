class Inventory < ApplicationRecord
  belongs_to :product

  # Validations
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
