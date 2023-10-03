class RemoveShelterFromApplications < ActiveRecord::Migration[7.0]
  def change
    remove_reference :applications, :shelter, null: false, foreign_key: true
  end
end
