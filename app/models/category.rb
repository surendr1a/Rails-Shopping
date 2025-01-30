class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories

  # Validations
  validates :name, presence: true
end
