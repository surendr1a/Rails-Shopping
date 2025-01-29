class CreateDiscounts < ActiveRecord::Migration[8.0]
  def change
    create_table :discounts do |t|
      t.string :code
      t.decimal :discount_amount
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
