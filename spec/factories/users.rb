# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, :aliases => [:jas] do
    name 'jas'
    password '123456'
    password_confirm '123456'
    email 'jas@gmail.com'
  end
end
