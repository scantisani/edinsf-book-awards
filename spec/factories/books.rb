FactoryBot.define do
  factory :book do
    author { Faker::Book.author }
    title { Faker::Book.title }
    chosen_by { Faker::Name.first_name }

    sequence(:published_at, 1900) { |n| Time.utc(n).getlocal }
    sequence(:read_at) { |n| Time.utc(2021, 1) + n.months }
  end
end
