class AddFieldsToShipping < ActiveRecord::Migration[8.0]
  def change
    add_column :shippings, :estimated_delivery_date, :date
    add_column :shippings, :shipped_date, :date
    add_column :shippings, :carrier, :string
  end
end
