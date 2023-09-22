require 'rails_helper'

RSpec.describe 'Pet application show page' do
  describe 'when visitng the application show page' do
    before :each do
      @shelter = create(:shelter)
      @pet1 = create(:pet, shelter: @shelter)
      @pet2 = create(:pet, shelter: @shelter)
      @pet3 = create(:pet, shelter: @shelter)
      @pet4 = create(:pet, shelter: @shelter)
      @pet5 = create(:pet, shelter: @shelter)
      @application1 = create(:application)
      @application2 = create(:application)
      @application3 = create(:application)
      @application_pet1 = create(:application_pet, pet: @pet1, application: @application1)
      @application_pet2 = create(:application_pet, pet: @pet1, application: @application1)
      @application_pet3 = create(:application_pet, pet: @pet1, application: @application2)
      @application_pet4 = create(:application_pet, pet: @pet2, application: @application3)
      @application_pet5 = create(:application_pet, pet: @pet3, application: @application3)
    end
    it 'shows the name of the applicant' do
      visit application_path(@application1.id)
      expect(page).to have_content("Applicant name: #{@application1.name}")

      visit application_path(@application2.id)
      expect(page).to have_content("Applicant name: #{@application2.name}")
    end

    it 'shows the full address of the applicant including street address, city, state, and zip' do
      visit application_path(@application1.id)
      expect(page).to have_content(
        "Address: #{@application1.address} #{@application1.address2}, #{@application1.city}, #{@application1.state}, #{@application1.zip_code}")
      
      visit application_path(@application3.id)
      expect(page).to have_content(
        "Address: #{@application3.address} #{@application3.address2}, #{@application3.city}, #{@application3.state}, #{@application3.zip_code}")
    end

    it "Description of why the applicant says they'd be a good home for this pet(s)" 

    it "names of all pets that this application is for (all names of pets should be links to their show page)"

    it "shows The Application's status, either In Progress, Pending, Accepted, or Rejected"
  end
end