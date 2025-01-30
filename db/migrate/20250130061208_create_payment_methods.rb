class CreatePaymentMethods < ActiveRecord::Migration[8.0]
  def change
    create_table :payment_methods do |t|
      t.references :user, null: false, foreign_key: true
      t.string :method
      t.string :card_number
      t.date :expiration_date
      t.text :billing_address

      t.timestamps
    end
  end
end
