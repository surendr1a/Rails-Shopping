class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  # Add product to the cart
  def add_product(product_id, quantity)
    existing_item = cart_items.find_by(product_id: product_id)
    
    if existing_item
      # If product exists in the cart, update quantity
      existing_item.update(quantity: existing_item.quantity + quantity)
    else
      # If not, create new cart item
      cart_items.create(product_id: product_id, quantity: quantity)
    end
  end

  # Remove product from the cart
  def remove_product(product_id)
    cart_item = cart_items.find_by(product_id: product_id)
    cart_item.destroy if cart_item
  end

  # Update quantity for a product in the cart
  def update_product_quantity(product_id, quantity)
    cart_item = cart_items.find_by(product_id: product_id)
    cart_item.update(quantity: quantity) if cart_item
  end
end
