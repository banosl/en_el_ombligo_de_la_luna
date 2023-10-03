require "rails_helper"

RSpec.describe "the shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
  end

  it "lists all the shelter names" do
    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  xit "lists the shelters by most recently created first" do
    visit "/shelters"

    oldest = find("#shelter-#{@shelter_1.id}")
    mid = find("#shelter-#{@shelter_2.id}")
    newest = find("#shelter-#{@shelter_3.id}")

    expect(newest).to appear_before(mid)
    expect(mid).to appear_before(oldest)

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_content("Created at: #{@shelter_1.created_at}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_content("Created at: #{@shelter_2.created_at}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_content("Created at: #{@shelter_3.created_at}")
    end
  end

  it "has a link to sort shelters by the number of pets they have" do
    visit "/shelters"

    expect(page).to have_link("Sort by number of pets")
    click_link("Sort by number of pets")

    expect(page).to have_current_path("/shelters?sort=pet_count")
    expect(@shelter_1.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_2.name)
  end

  it "has a link to update each shelter" do
    visit "/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Update #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Update #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Update #{@shelter_3.name}")
    end

    click_on("Update #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/edit")
  end

  it "has a link to delete each shelter" do
    visit "/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Delete #{@shelter_1.name}")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_link("Delete #{@shelter_2.name}")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_link("Delete #{@shelter_3.name}")
    end

    click_on("Delete #{@shelter_1.name}")
    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
  end

  it "has a text box to filter results by keyword" do
    visit "/shelters"
    expect(page).to have_button("Search")
  end

  it "lists partial matches as search results" do
    visit "/shelters"

    fill_in "Search", with: "RGV"
    click_on("Search")

    expect(page).to have_content(@shelter_2.name)
    expect(page).to_not have_content(@shelter_1.name)
  end

  it "lists shelters in reverse alphabetical order by name" do
    visit "/shelters"

    a = find("#shelter-#{@shelter_1.id}")
    r = find("#shelter-#{@shelter_2.id}")
    f = find("#shelter-#{@shelter_3.id}")
    
    expect(r).to appear_before(f)
    expect(r).to appear_before(a)
    expect(f).to appear_before(a)
  end

  it "in the section 'shelters with pending applications' is see the name of every shelter that has apps pending" do
    pet1 = create(:pet, shelter: @shelter_1)
    pet2 = create(:pet, shelter: @shelter_2)
    pet3 = create(:pet, shelter: @shelter_3)
    pet4 = create(:pet, shelter: @shelter_3)
    pet5 = create(:pet, shelter: @shelter_1)
    application1 = create(:application, status: 1)
    application2 = create(:application, status: 0)
    application3 = create(:application, status: 1)
    application_pet1 = create(:application_pet, pet: pet1, application: application1)
    application_pet2 = create(:application_pet, pet: pet3, application: application1)
    application_pet3 = create(:application_pet, pet: pet1, application: application2)
    application_pet5 = create(:application_pet, pet: pet3, application: application3)

    visit "/shelters"
    
    within "#shelters_with_pending_apps" do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_3.name)
      expect(page).to_not have_content(@shelter_2.name)
    end
  end
end
