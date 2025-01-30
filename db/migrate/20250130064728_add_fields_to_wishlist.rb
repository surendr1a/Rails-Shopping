class AddFieldsToWishlist < ActiveRecord::Migration[8.0]
  def change
    add_column :wishlists, :status, :boolean
    add_column :wishlists, :priority, :integer
  end
end
