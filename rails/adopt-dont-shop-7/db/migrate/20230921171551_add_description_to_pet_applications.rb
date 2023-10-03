class AddDescriptionToPetApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :pet_applications, :description, :string
  end
end
