FactoryBot.define do
  factory :user do
    sequence(:email) { |i| "email#{i}@gmail.com" }
    password { 'test_password' }
    locale { 'en' }
    avatar { nil }
  end
end
