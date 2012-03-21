FactoryGirl.define do
  factory :user, :aliases => [:jas] do
    name 'jas'
    password '1'
    email 'jas@gmail.com'
  end

  factory :article do
    sequence(:title) {|n| "factory title:#{n}" }
    sequence(:content) {|n|"factory content:#{n}"}
    association :user, :factory => :user
    factory :article_with_fakeuser do
      association :user, :factory => :user, :name => 'fakeuser', :password => 'fakepass', :email => 'faker@rails.com'
    end
  end

  factory :reply do
    content 'reply content'
    association :user, :factory => :user#, :strategy => :build
    association :article, :factory => :article_with_fakeuser#, :strategy => :build 
  end

  factory :tag do
    name "tag_test"
  end

  factory :ats, :class => 'ArticleTagship' do
    article :factory => :article 
    tag :factory => :tag
  end

  factory :catagory, :class => 'Catagory'  do
    association :user, :factory => :user, :strategy => :build 
#    association :article, :factory => :article, :strategy => :build 
    name "catagory_test"   
  end
end
