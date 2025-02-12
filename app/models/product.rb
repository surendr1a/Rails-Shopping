class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  # has_many :reviews, dependent: :destroy

  
  # Validations
  validates :name, presence: true 
  validates :stock_quantity, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }  
  validates :description, presence: true

  def self.ransackable_attributes(auth_object = nil)
    super + ["name", "description", "price", "stock_quantity"]
  end
  ransack_alias :name_or_description, [:name, :description]
end
