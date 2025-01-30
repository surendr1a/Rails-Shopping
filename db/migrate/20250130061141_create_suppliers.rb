class CreateSuppliers < ActiveRecord::Migration[8.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
