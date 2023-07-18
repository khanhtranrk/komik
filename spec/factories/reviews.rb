FactoryBot.define do
  factory :review do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
