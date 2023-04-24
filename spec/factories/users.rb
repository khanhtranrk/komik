FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    birthday { Time.zone.now }
  end

  factory :invalid_user, parent: :contact do
    username { nil }
    email { nil }
    password { nil }
    birthday { nil }
  end
end
