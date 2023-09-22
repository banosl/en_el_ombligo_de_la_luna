FactoryBot.define do
  factory :shelter do
    name {"#{Faker::Appliance.brand} Shelter"}
    city {Faker::Address.city}
    rank {Faker::Number.between(from: 1, to:1000)}
  end

  factory :pet do
    name {Faker::Creature::Dog.name}
    age {Faker::Number.between(from: 1, to: 20)}
    shelter
  end

end