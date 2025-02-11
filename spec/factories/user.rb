# This will guess the User class
FactoryBot.define do
  factory :user do
    # name { "surendra chourasiya" }
    # sequence(:email) { |n| "test#{n}@example.com" }
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password {"123456"}
  end
end