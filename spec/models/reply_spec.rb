require 'spec_helper'

describe Reply do
  before(:all)  do 
#    @user = Factory.create(:user)
#    @article = Factory.create(:article,{user:@user})
    @reply = Factory.build(:reply)
  end

  context "test association" do 
    it "create test" do
      @reply.save.should be_true
      @reply.new_record?.should be_false
      @reply.article.title.should =~ /factory title:\d/
      @reply.user.name.should == "jas"
    end
  end
end
