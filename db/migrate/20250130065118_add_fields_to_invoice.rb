class AddFieldsToInvoice < ActiveRecord::Migration[8.0]
  def change
    add_column :invoices, :paid_amount, :decimal
    add_column :invoices, :payment_status, :string
  end
end
