require 'spec_helper'
describe User do
  before(:all) do
    @user = Factory.build(:user)
    @user.save
    @tag = Factory.build(:tag)
    @as = []
    10.times do |i|
#      @as << Article.new(title:"fuck #{i}times",content:"really? i think you fuck #{i*Random.rand(50)}times")
      @as << Factory.build(:article, {title:"fuck #{i}times", content:"thank you", user:@user})
    end
  end

  context "when initialize" do 
    it "test the 'before' db insert" do
      @user.name.should == "jas"
      (@user.tags << @tag).should be_true
      @user.tags[0].name.should == "tag_test"

    end
    
    it "validates_presence_of name and email and password" do
      u = User.new(birthday:"2011-12-15")
      u.save.should be_false
      u.name = "fuck"
      u.password = "shit"
      u.email = "shit@shit.com"
      u.save.should be_true
    end
  end

  context "test association " do
    it "has many articles" do
      @as.each do |a|
        a.save.should be_true
        @user.articles << a
        @user.save.should be_true
      end
      @user.articles.size.should == 10
    end
  end
end
