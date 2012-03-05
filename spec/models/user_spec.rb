require 'spec_helper'
describe User do
  before(:each) do
    @user = User.create(name:'test',password:1,email:'fuck')
#    @user = User.new(name:"a",password:1)
    @tag = Tag.create(name:"fuck")
  end
  
  context "when initialize" do 
    it "the @user.name should be test" do
      @user.name.should == "test"
      (@user.tags << @tag).should be_true
      @user.tags[0].name.should == "fuck"
    end

  end
end
