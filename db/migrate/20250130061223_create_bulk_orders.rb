class CreateBulkOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :bulk_orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :total_price
      t.string :status

      t.timestamps
    end
  end
end
