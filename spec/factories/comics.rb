FactoryBot.define do
  factory :comic do
    name { Faker::Book.title }
    active { true }
  end
end
