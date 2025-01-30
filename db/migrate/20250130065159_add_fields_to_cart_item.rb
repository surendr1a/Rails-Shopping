class AddFieldsToCartItem < ActiveRecord::Migration[8.0]
  def change
    add_column :cart_items, :total_price, :decimal
  end
end
