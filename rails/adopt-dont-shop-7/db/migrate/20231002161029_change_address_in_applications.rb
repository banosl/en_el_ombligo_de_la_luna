class ChangeAddressInApplications < ActiveRecord::Migration[7.0]
  def change
    rename_column(:applications, :address, :address_1)
    rename_column(:applications, :address2, :address_2)
  end
end
