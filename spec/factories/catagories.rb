#encoding: UTF-8
FactoryGirl.define do
  factory :catagory, :class => 'Catagory' do
    association :user, factory: :user
    sequence(:name) {|n| "分类#{n}" }
  end
end
