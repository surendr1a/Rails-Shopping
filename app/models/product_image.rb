class ProductImage < ApplicationRecord
  belongs_to :product

  # Validations
  # validates :image_url, presence: true
end
