class AddFieldsToPurchaseOrder < ActiveRecord::Migration[8.0]
  def change
    add_column :purchase_orders, :status, :string
    add_column :purchase_orders, :supplier_order_number, :string
  end
end
