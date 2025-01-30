class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  has_one :invoice
  has_one :shipping
  has_one :order_transaction

  # Validations
  validates :status, inclusion: { in: %w[pending processed shipped delivered canceled] }
end
