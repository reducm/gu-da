# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    sequence(:title) {|n| "factory title:#{n}" }
    sequence(:content) {|n|"factory content:#{n}"}
    association :user, :factory => :user
  end
end
