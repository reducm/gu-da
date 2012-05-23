# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    file "MyString"
    file_name "MyString"
    file_type "MyString"
    file_size 1
    pictureable_type "MyString"
    pictureable_id "MyString"
  end
end
