class Transaction < ApplicationRecord
  belongs_to :order

  # Validations
  validates :transaction_id, presence: true, uniqueness: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
