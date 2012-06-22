# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :catagory, :class => 'Catagory'  do
    association :user, :factory => :user, :strategy => :build 
#    association :article, :factory => :article, :strategy => :build 
    name "catagory_test"   
  end
end
