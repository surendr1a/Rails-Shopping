class AddFieldsToProductImage < ActiveRecord::Migration[8.0]
  def change
    add_column :product_images, :alt_text, :string
  end
end
