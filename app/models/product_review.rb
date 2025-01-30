class ProductReview < ApplicationRecord
  belongs_to :user
  belongs_to :product

  # Validations
  # validates :rating, inclusion: { in: 1..5 }
  # validates :comment, length: { maximum: 1000 }
end
