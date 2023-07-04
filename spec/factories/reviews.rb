FactoryBot.define do
  factory :review do
    association :user
    comment { "Great product!" }
    rating { 5 }
  end
end