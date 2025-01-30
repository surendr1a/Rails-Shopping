class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :order, null: false, foreign_key: true
      t.string :invoice_number
      t.decimal :total_amount
      t.date :due_date

      t.timestamps
    end
  end
end
