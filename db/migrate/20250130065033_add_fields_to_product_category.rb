class AddFieldsToProductCategory < ActiveRecord::Migration[8.0]
  def change
    add_column :product_categories, :is_active, :boolean
  end
end
