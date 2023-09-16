FactoryBot.define do
  factory :comic do
    name { Faker::Book.title }
    active { true }
  end

  factory :inactive_comic, class: Comic do
    name { Faker::Book.title }
    active { false }
  end
end
