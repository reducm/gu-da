FactoryGirl.define do
    factory :user do
        name 'jas'
        password '1'
        email 'gmail'
    end
    
    factory :article do
        title 'factory' 
        content 'factory content'
        user Factory.build(:user)
    end
end
