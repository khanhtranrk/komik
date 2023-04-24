FactoryBot.define do
  factory :category do
    name { Faker::Book.genre }
    description { Faker::Book.genre }
  end

  factory :invalid_contact, parent: :contact do
    name { nil }
    description { nil }
  end
end
