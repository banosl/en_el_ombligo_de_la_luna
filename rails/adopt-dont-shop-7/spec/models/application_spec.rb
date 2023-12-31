require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name } 
    it { should validate_presence_of :last_name } 
    it { should validate_presence_of :address_1 } 
    it { should validate_presence_of :city } 
    it { should validate_presence_of :state } 
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :description}
  end
end