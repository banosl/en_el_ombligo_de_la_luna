FactoryBot.define do
  factory :shelter do
    name {"#{Faker::Appliance.brand} Shelter"}
    city {Faker::Address.city}
    rank {Faker::Number.between(from: 1, to:1000)}
    foster_program {Faker::Boolean.boolean}
  end

  factory :pet do
    name {Faker::Creature::Dog.name}
    age {Faker::Number.between(from: 1, to: 20)}
    shelter
  end

  factory :application do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    address_1 {Faker::Address.street_address}
    address_2 {Faker::Address.secondary_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zip_code {Faker::Address.zip_code}
    description {Faker::JapaneseMedia::OnePiece.quote}
  end

  factory :application_pet do
    pet
    application
  end
end