require 'spec_helper'

describe Catagory do
  before(:each) do
    @u = Factory.create(:user)
    @c = Factory.build(:catagory, {user:@u})

  end
  
  it "test CRUD" do
    @c.save.should == true
    @c.new_record?.should == false

    10.times do |i|
      @a = Factory.build(:article,{user:@u,catagory:@c})
      @a.save
    end

    @c.user.name.should == 'jas'
    @c.save
    @c.articles.size.should == 10
  end
end
