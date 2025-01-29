class CreateProductReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :product_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :rating
      t.text :review

      t.timestamps
    end
  end
end
