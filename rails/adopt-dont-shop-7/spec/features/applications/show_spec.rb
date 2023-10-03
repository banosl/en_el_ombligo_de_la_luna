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
          within ("#pet_#{@pet7.id}") do
            click_link "Adopt this Pet"
          end
        end
      end

      within ("#pets") do
        expect(page).to have_content("\n#{@pet1.name} #{@pet7.name}")
      end
    end

    it "submit an application after adding pets to it. After submitting the application the status changes
        to 'pending' and the search function and add pet to application function are no longer available.
        In the submission section there is also a field for 'why I would make a good owner for these pets'" do
        visit application_path(@application1)

        within ("#pets") do
          expect(page).to have_content("\n#{@pet1.name} #{@pet2.name} #{@pet3.name}")
        end

        within ("#searching_pets") do
          expect(page).to have_content("Add a pet to the application")
          expect(page).to have_field(:pet_search)
          expect(page).to have_button("Search")
        end

        within ("#form_submission") do
          expect(page).to have_field(:good_owner)
          expect(page).to have_button("Submit application")

          fill_in :good_owner, with: Faker::JapaneseMedia::OnePiece.quote
          click_button "Submit application"
        end
       
        expect(page).to have_content("Application status: Pending")
        expect(page).to_not have_content("Add a pet to the application")
        expect(page).to_not have_field(:pet_search)
        expect(page).to_not have_button("Search")
        expect(page).to_not have_field(:good_owner)
        expect(page).to_not have_button("Submit application")
    end

    it "when there are not pets on an application, a user can't submit the application" do
      application4 = create(:application, shelter: @shelter)

      visit application_path(application4.id)
      expect(page).to_not have_button("Submit application")
    end

    describe "Database Logic Part 1" do
      before :each do
        @pet11 = Pet.create({name: "fluffy", age: 4, shelter_id: @shelter.id})
        @pet12 = Pet.create({name: "fluff", age: 1, shelter_id: @shelter.id})
        @pet13 = Pet.create({name: "mr. fluff", age: 6, shelter_id: @shelter.id})
        @pet14 = Pet.create({name: "Fluffy", age: 4, shelter_id: @shelter.id})
        @pet15 = Pet.create({name: "FLUFF", age: 1, shelter_id: @shelter.id})
        @pet16 = Pet.create({name: "Mr. FLUFF", age: 6, shelter_id: @shelter.id})
      end
      it "I search for pets by name and I see any pet whose name partially matches my search" do
        visit application_path(@application2)

        within ("#searching_pets") do
          expect(page).to have_content("Add a pet to the application")
          expect(page).to have_field(:pet_search)
          expect(page).to have_button("Search")

          fill_in :pet_search, with: "fluff"
          click_button("Search")
        end

        within ("#results") do
          expect(page).to have_content(@pet11.name)
          expect(page).to have_content(@pet12.name)
          expect(page).to have_content(@pet13.name)
        end
      end

      it "I search for pets by name and I see any pet whose name partially matches my search and is case insensitive" do
        visit application_path(@application2)

        within ("#searching_pets") do
          expect(page).to have_content("Add a pet to the application")
          expect(page).to have_field(:pet_search)
          expect(page).to have_button("Search")

          fill_in :pet_search, with: "fluff"
          click_button("Search")
        end

        within ("#results") do
          expect(page).to have_content(@pet14.name)
          expect(page).to have_content(@pet15.name)
          expect(page).to have_content(@pet16.name)
        end
      end
    end
  end
end