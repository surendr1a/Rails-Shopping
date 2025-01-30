class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  # Validations
  validates :status, inclusion: { in: %w[active abandoned] }
end
