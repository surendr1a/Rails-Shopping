class AddFieldsToOrder < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :shipping_cost, :decimal
    add_column :orders, :discount_applied, :decimal
  end
end
