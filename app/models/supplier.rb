class Supplier < ApplicationRecord
  has_many :purchase_orders

  # Validations
  validates :name, presence: true
  validates :contact_email, presence: true, uniqueness: true
end
