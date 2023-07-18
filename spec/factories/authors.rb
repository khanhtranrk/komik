FactoryBot.define do
  factory :author do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birthday { Time.zone.now }
    introduction { Faker::Lorem.paragraph }
  end
end
