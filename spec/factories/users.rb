FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birthday { Time.zone.now }
    role { 0 }
  end

  factory :admin do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birthday { Time.zone.now }
    role { 1 }
  end
end
