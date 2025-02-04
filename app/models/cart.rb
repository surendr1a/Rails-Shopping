class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def add_product(product_id, quantity)
    existing_item = cart_items.find_by(product_id: product_id)
    
    if existing_item
      existing_item.update(quantity: existing_item.quantity + quantity)
    else
      cart_items.create(product_id: product_id, quantity: quantity)
    end
  end

  def remove_product(product_id)
    cart_item = cart_items.find_by(product_id: product_id)
    cart_item.destroy if cart_item
  end

  def update_product_quantity(product_id, quantity)
    cart_item = cart_items.find_by(product_id: product_id)
    cart_item.update(quantity: quantity) if cart_item
  end
end
