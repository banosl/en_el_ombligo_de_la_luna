class RemovePetFromPetApplications < ActiveRecord::Migration[7.0]
  def change
    remove_reference :pet_applications, :pet, null: false, foreign_key: true
  end
end
