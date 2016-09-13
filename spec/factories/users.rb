FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@user_#{n}.com" }
    password "hoge1234"
  end
end
