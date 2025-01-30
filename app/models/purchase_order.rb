class PurchaseOrder < ApplicationRecord
  belongs_to :supplier
  belongs_to :product

  # Validations
  validates :order_number, presence: true, uniqueness: true
  validates :quantity, numericality: { greater_than: 0 }
end
