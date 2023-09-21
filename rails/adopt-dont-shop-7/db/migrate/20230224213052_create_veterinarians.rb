class CreateVeterinarians < ActiveRecord::Migration[7.0]
  def change
    create_table :veterinarians do |t|
      t.boolean :on_call
      t.integer :review_rating
      t.string :name
      t.references :veterinary_office, null: false, foreign_key: true

      t.timestamps
    end
  end
end
