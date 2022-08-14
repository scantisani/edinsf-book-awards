FactoryBot.define do
  factory :ranking do
    user
    book
    sequence :position, (0..11).cycle
  end
end
