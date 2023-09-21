class PetApplication < ApplicationRecord
  belongs_to :pet

  validates :first_name, presence: true 
  validates :last_name, presence: true
  validates :address, presence: true
  validates :address2, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
end