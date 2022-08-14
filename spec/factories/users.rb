FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.first_name }
  end
end
