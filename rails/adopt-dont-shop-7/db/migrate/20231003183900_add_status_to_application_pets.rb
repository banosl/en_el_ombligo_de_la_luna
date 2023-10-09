class AddStatusToApplicationPets < ActiveRecord::Migration[7.0]
  def change
    add_column :application_pets, :status, :integer, default: 0
  end
end
