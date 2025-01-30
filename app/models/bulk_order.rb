class BulkOrder < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  # Validations
  validates :order_number, presence: true
  validates :status, inclusion: { in: %w[pending processed shipped delivered] }
end
