require 'rails_helper'

RSpec.describe "visiting the new application form page" do
  before :each do
    @shelter = create(:shelter)
    @pet1 = create(:pet, shelter: @shelter)
    @pet2 = create(:pet, shelter: @shelter)
    @pet3 = create(:pet, shelter: @shelter)
    @pet4 = create(:pet, shelter: @shelter)
    @pet5 = create(:pet, shelter: @shelter)
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

  it 'can fill out the form, be redirected to the application show page and view the information entered plus the status' do
    visit pet_path(@pet1.id)
    click_link "Start an Application"
    expect(current_path).to eq(new_application_path)

    fill_in "First name", with: "Bob"
    fill_in "Last name", with: "Suarez de la Torre"
    fill_in :address_1, with: "123 S Havana St"
    fill_in "City", with: "Wheat Ridge"
    fill_in "State", with: "CO"
    fill_in "Zip Code", with: "80033"
    fill_in "Why would you make a good home?", with: "Because I love animals and I have a 400 acre yard for them run wild and free."

    click_button "submit"

    save_and_open_page
    expect(page).to have_content("Applicant name: Bob Suarez de la Torre")
    expect(page).to have_content("Address: 123 S Havana St, Wheat Ridge, CO, 80033")
    expect(page).to have_content("Why we'd make a good home for these pet(s): Because I love animals and I have a 400 acre yard for them run wild and free.")
    expect(page).to have_content("Application status: In Progress")
  end
end