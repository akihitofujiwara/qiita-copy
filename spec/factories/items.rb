FactoryGirl.define do
  factory :item do
    sequence(:title) { |n| "item_#{n}" }
    sequence(:body) { |n| "# Item #{n}" }
    sequence(:tag_list) { |n| "ruby rails #{n}" }
  end
end
