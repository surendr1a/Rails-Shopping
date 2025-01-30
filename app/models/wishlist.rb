class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :product

  # Validations
  validates :product_id, uniqueness: { scope: :user_id }
end
