class Invoice < ApplicationRecord
  belongs_to :order

  # Validations
  validates :invoice_number, presence: true, uniqueness: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
