class CreateVeterinaryOffices < ActiveRecord::Migration[7.0]
  def change
    create_table :veterinary_offices do |t|
      t.boolean :boarding_services
      t.integer :max_patient_capacity
      t.string :name

      t.timestamps
    end
  end
end
