class ProductCategory < ApplicationRecord
  belongs_to :product
  belongs_to :category

  # Validations
  # validates :product_id, uniqueness: { scope: :category_id }
end
