class CreateShippings < ActiveRecord::Migration[8.0]
  def change
    create_table :shippings do |t|
      t.references :order, null: false, foreign_key: true
      t.text :shipping_address
      t.string :shipping_status
      t.string :tracking_number

      t.timestamps
    end
  end
end
