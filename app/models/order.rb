class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  
  validates :status, presence: true, inclusion: { in: %w[pending completed cancelled] }
end
