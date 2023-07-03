FactoryBot.define do
  factory :author do
    first_name { "MyString" }
    last_name { "MyString" }
    birthday { "2023-07-01 16:56:27" }
    introduction { "MyText" }
  end
end
