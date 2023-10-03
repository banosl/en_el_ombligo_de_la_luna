class ChangePetApplicationsToApplications < ActiveRecord::Migration[7.0]
  def change
    rename_table :pet_applications, :applications
  end
end
