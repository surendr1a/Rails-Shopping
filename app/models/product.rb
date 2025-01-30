class Product < ApplicationRecord
  has_many :product_reviews
  has_many :order_items
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :product_images

  # Validations
  # validates :name, presence: true
  # validates :price, numericality: { greater_than: 0 }
  # validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
end
