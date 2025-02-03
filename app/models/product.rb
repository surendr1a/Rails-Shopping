class Product < ApplicationRecord
  # belongs_to :cart
  belongs_to :user
  # Validations
  # validates :name, presence: true
  # validates :price, numericality: { greater_than: 0 }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  
  def self.ransackable_attributes(auth_object = nil)
    super + ["name", "description", "price", "stock_quantity"]
  end
  ransack_alias :name_or_description, [:name, :description]
end
