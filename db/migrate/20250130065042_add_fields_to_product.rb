class AddFieldsToProduct < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :sku, :string
    add_column :products, :is_active, :boolean
    add_column :products, :weight, :decimal
    add_column :products, :brand, :string
    add_column :products, :color, :string
  end
end
