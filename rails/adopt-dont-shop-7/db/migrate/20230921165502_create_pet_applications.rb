class CreatePetApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :pet_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zip_code
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
