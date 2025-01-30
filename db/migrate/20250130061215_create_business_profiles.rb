class CreateBusinessProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :business_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :business_name
      t.string :business_type
      t.text :address
      t.string :contact_number

      t.timestamps
    end
  end
end
