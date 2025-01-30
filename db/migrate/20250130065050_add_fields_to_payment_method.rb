class AddFieldsToPaymentMethod < ActiveRecord::Migration[8.0]
  def change
    add_column :payment_methods, :expiry_month, :integer
    add_column :payment_methods, :expiry_year, :integer
    add_column :payment_methods, :is_primary, :boolean
  end
end
