# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    senderable_id 1
    senderable_type "MyString"
    reciever_id 1
    content "MyString"
    readed false
  end
end
