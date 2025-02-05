class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.string :order_id
      t.string :payment_id
      t.string :status
      t.integer :amount
      t.string :currency
      t.string :signature

      t.timestamps
    end
  end
end
