FactoryBot.define do
  factory :category do
    name { Faker::Book.genre }
    description { Faker::Book.genre }
  end
end
