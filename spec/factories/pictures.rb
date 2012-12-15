# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    file File.open("#{Rails.root}/app/assets/images/rails.png")
    association :pictureable, factory: :jas
  end
end
