require 'rails_helper'

RSpec.describe PetApplication do
  describe 'relationships' do
    it { should belong_to(:pet) }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name } 
    it { should validate_presence_of :last_name } 
    it { should validate_presence_of :address } 
    it { should validate_presence_of :address2 } 
    it { should validate_presence_of :city } 
    it { should validate_presence_of :state } 
    it { should validate_presence_of :zip_code }
    it { should validate_numericality_of :zip_code}
  end
end