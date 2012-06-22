# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    sequence(:title) {|n| "factory title:#{n}" }
    sequence(:content) {|n|"factory content:#{n}"}
    association :user, :factory => :user
    factory :article_with_fakeuser do
      association :user, :factory => :user, :name => 'fakeuser', :password_confirm => 'fakepass', :password => 'fakepass', :email => 'faker@rails.com'
    end
  end
end
