# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    sequence(:title) {|n| "factory title:#{n}" }
    sequence(:content) {|n|"factory content:#{n}"}
    sequence(:subtitle) {|n|"subtitle :#{n}"}
  end
end
