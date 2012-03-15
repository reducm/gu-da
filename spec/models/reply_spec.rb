require 'spec_helper'

describe Reply do
  before(:all)  do 
    @reply = Factory.build(:reply)
  end

  context "test association" do 
    it "create test" do
      @reply.save.should be_true
      @reply.new_record?.should be_false
      @reply.article.title.should == "factory"
      @reply.user.name.should == "jas"
    end
  end
end
