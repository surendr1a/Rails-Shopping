class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  # Validations
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }


  def self.ransackable_attributes(auth_object = nil)
    super + ["name", "description", "price", "stock_quantity"]
  end
  ransack_alias :name_or_description, [:name, :description]


  # Custom validation to ensure that stock quantity does not exceed available stock
  
end
