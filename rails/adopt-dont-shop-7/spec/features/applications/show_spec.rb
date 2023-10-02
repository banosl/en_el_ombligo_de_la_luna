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
      @pet6 = create(:pet, shelter: @shelter)
      @pet7 = create(:pet, shelter: @shelter)
      @pet8 = create(:pet, shelter: @shelter)
      @pet9 = create(:pet, shelter: @shelter)
      @pet10 = create(:pet, shelter: @shelter)
      @application1 = create(:application, shelter: @shelter)
      @application2 = create(:application, shelter: @shelter)
      @application3 = create(:application, shelter: @shelter)
      @application_pet1 = create(:application_pet, pet: @pet1, application: @application1)
      @application_pet2 = create(:application_pet, pet: @pet3, application: @application1)
      @application_pet3 = create(:application_pet, pet: @pet1, application: @application2)
      @application_pet4 = create(:application_pet, pet: @pet2, application: @application3)
      @application_pet5 = create(:application_pet, pet: @pet3, application: @application3)
      @application_pet6 = create(:application_pet, pet: @pet2, application: @application1)
    end
    it 'shows the name of the applicant' do
      visit application_path(@application1.id)
      expect(page).to have_content("Applicant name: #{@application1.first_name} #{@application1.last_name}")

      visit application_path(@application2.id)
      expect(page).to have_content("Applicant name: #{@application2.first_name} #{@application2.last_name}")
    end

    it 'shows the full address of the applicant including street address, city, state, and zip' do
      visit application_path(@application1.id)
      expect(page).to have_content(
        "Address: #{@application1.address_1} #{@application1.address_2}, #{@application1.city}, #{@application1.state}, #{@application1.zip_code}")
      
      visit application_path(@application3.id)
      expect(page).to have_content(
        "Address: #{@application3.address_1} #{@application3.address_2}, #{@application3.city}, #{@application3.state}, #{@application3.zip_code}")
    end

    it "Description of why the applicant says they'd be a good home for this pet(s)" do
      visit application_path(@application2.id)
      expect(page).to have_content("Why we'd make a good home for these pet(s): #{@application2.description}")

      visit application_path(@application3.id)
      expect(page).to have_content("Why we'd make a good home for these pet(s): #{@application3.description}")

      visit application_path(@application1.id)
      expect(page).to have_content("Why we'd make a good home for these pet(s): #{@application1.description}")
    end
    
    it "names of all pets that this application is for (all names of pets should be links to their show page)" do
      visit application_path(@application2.id)
      within ("#pets") do
        expect(page).to have_content("\n#{@pet1.name}")
      end
      
      visit application_path(@application3.id)
      within ("#pets") do
        expect(page).to have_content("\n#{@pet2.name} #{@pet3.name}")
      end
    end

    it "shows The Application's status, either In Progress, Pending, Accepted, or Rejected" do
      visit application_path(@application2.id)
      expect(page).to have_content("Application status: In Progress")

      visit application_path(@application3.id)
      expect(page).to have_content("Application status: In Progress")
    end

    it "each pet name is a link to the pet's show page" do
      visit application_path(@application1.id)

      expect(page).to have_link("#{@pet1.name}", :href => pet_path(@pet1.id))
      expect(page).to have_link("#{@pet3.name}", :href => pet_path(@pet3.id))
      expect(page).to have_link("#{@pet2.name}", :href => pet_path(@pet2.id))
    end

    it "when application has not been submitted, I see an input where I can search a pet by name
      when I fill in this field with a name and click submit, the page reloads with results that match" do
      visit application_path(@application2)

      within ("#searching_pets") do
        expect(page).to have_content("Add a pet to the application")
        expect(page).to have_field(:pet_search)
        expect(page).to have_button("Search")

        fill_in :pet_search, with: @pet7.name
        click_button("Search")

        within ("#results") do
          expect(page).to have_content(@pet7.name)
        end
      end
    end

    it "when I search for a pet on an application, in the results I see the name of the pet plust the
      option to 'Adopt this Pet'. After clicking on it, the pet is populated under 'Pets on application" do
      visit application_path(@application2)

      within ("#searching_pets") do
        expect(page).to have_content("Add a pet to the application")
        expect(page).to have_field(:pet_search)
        expect(page).to have_button("Search")

        fill_in :pet_search, with: @pet7.name
        click_button("Search")

        within ("#results") do
          click_link "Adopt this Pet"
        end
      end

      within ("#pets") do
        expect(page).to have_content("\n#{@pet1.name} #{@pet7.name}")
      end
      save_and_open_page
    end
  end
end