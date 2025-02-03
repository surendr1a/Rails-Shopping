class AddCartIdToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :cart_id, :integer
  end
end
