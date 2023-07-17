FactoryBot.define do
  factory :review do
    user_id { "" }
    comic_id { "" }
    title { "MyString" }
    content { "MyText" }
  end
end
