class AddShelterToApplications < ActiveRecord::Migration[7.0]
  def change
    add_reference :applications, :shelter, null: false, foreign_key: true
  end
end
