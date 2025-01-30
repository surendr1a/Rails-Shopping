class Discount < ApplicationRecord
  # Validations
  validates :code, presence: true, uniqueness: true
  validates :percentage, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
end
