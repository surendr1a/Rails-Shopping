class AddFieldsToBusinessProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :business_profiles, :contact_name, :string
    add_column :business_profiles, :phone, :string
  end
end
