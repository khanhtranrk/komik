FactoryBot.define do
  factory :comment do
    user_id { "" }
    comic_id { "" }
    title { "MyString" }
    content { "MyText" }
  end
end
