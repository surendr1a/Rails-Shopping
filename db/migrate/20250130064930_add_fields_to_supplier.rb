class AddFieldsToSupplier < ActiveRecord::Migration[8.0]
  def change
    add_column :suppliers, :contact_person, :string
    add_column :suppliers, :rating, :decimal
    add_column :suppliers, :is_active, :boolean
  end
end
