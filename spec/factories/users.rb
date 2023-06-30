FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    birthday { Time.zone.now }
    role { 1 }
    locked { false }
  end
end
