class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets

  validates :first_name, presence: true 
  validates :last_name, presence: true
  validates :address_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :status, presence: true

  enum status: ["In Progress", "Pending", "Accepted", "Rejected"]
end