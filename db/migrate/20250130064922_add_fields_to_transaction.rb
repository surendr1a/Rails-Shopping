class AddFieldsToTransaction < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :transaction_id, :string
    add_column :transactions, :payment_gateway, :string
    add_column :transactions, :payment_status, :string
  end
end
