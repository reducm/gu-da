# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    sequence(:content) {|n| "asdas#{n}"}
    association :user, factory: :user
  end

  factory :anonymous_comment, class:Comment do
    sequence(:content) {|n| "asdas#{n}"}
    sequence(:visitor_name) {|n| "user_name#{n}"}
    sequence(:visitor_email) {|n| "e#{n}@e.com"}
    user_id 0
  end
end
