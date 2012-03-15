FactoryGirl.define do
    factory :user, :aliases => [:jas] do
        name 'jas'
        password '1'
        email 'gmail'
    end
    
    factory :article do
        title 'factory' 
        content 'factory content'
        association :user ,:factory => :user, :strategy => :build
    end

    factory :reply do
      content 'reply content'
      association :user, :factory => :user#, :strategy => :build
      association :article, :factory => :article#, :strategy => :build 
    end
end
