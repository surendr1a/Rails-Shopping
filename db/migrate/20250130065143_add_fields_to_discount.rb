class AddFieldsToDiscount < ActiveRecord::Migration[8.0]
  def change
    add_column :discounts, :minimum_order_amount, :decimal
  end
end
