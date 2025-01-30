class AddFieldsToProductReview < ActiveRecord::Migration[8.0]
  def change
    add_column :product_reviews, :title, :string
    add_column :product_reviews, :is_verified_purchase, :boolean
  end
end
