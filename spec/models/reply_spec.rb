require 'spec_helper'

describe Reply do
  before(:all)  do 
    @user = User.create(name:"tissue", password:"fuck", email:"f")
    @article = Article.create(title:"hi", content:"hi c",user:@user)
    @reply = Reply.create(content:"fantasy tissue",user:@user, article:@article)
  end

  context "test association" do 
    it "create test" do
      @reply.article.title.should == "hi"
      @reply.user.name.should == "tissue"
    end
  end
end
