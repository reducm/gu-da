require 'spec_helper'

describe Reply do
  before(:all)  do 
    @user = Factory.build(:user)
    @article = Factory.build(:article)
    @reply = Reply.create(content:"fantasy tissue",user:@user, article:@article)
  end

  context "test association" do 
    it "create test" do
      @reply.article.title.should == "factory"
      @reply.user.name.should == "jas"
    end
  end
end
