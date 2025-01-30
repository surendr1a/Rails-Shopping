class AddFieldsToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :is_verified, :boolean
    add_column :users, :profile_picture, :string
    add_column :users, :dob, :date
    add_column :users, :last_login_at, :datetime
  end
end
