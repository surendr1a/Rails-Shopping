class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :order, null: false, foreign_key: true
      t.decimal :amount
      t.string :status
      t.string :transaction_type

      t.timestamps
    end
  end
end
