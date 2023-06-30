FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}"}
    sequence (:price) {|n| 10.99 + n}
    description { "Collar for cat"}
    association :user
    association :category

  end
end
