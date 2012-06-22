# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, :aliases => [:jas] do
    name 'jas'
    password 'aaaaaa'
    password_confirm 'aaaaaa'
    email 'jas@gmail.com'
  end
end
