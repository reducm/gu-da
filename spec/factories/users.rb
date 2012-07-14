# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:nickname) {|n| "user#{n}"}
    password 'aaaaaa'
    password_confirm 'aaaaaa'
    sequence(:email) {|n|"user#{n}@gmail.com"}
  end

  factory :jas, :class => User do
    nickname 'jas'
    password 'aaaaaa'
    password_confirm 'aaaaaa'
    email 'jas@gmail.com'
  end
end
