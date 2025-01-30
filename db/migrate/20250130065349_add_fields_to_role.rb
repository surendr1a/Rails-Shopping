class AddFieldsToRole < ActiveRecord::Migration[8.0]
  def change
    add_column :roles, :description, :text
    add_column :roles, :permissions, :json
  end
end
