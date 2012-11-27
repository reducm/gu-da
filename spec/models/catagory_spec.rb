#encoding: UTF-8
require 'spec_helper'

describe Catagory do
  before(:each) do
    @jas = FactoryGirl.create(:jas)
    10.times {FactoryGirl.create(:catagory,user:@jas)}
  end

  context "class function" do
    it "get_all" do
      cs = Catagory.get_all(@jas.id)
      cs.class.should == Array
      cs.size.should == 11
      cs[cs.size-1].name.should == '默认分类'
      cs[cs.size-1].id.should == 0
      cs[cs.size-1].user_id.should == @jas.id
    end

    it "default" do
      c = Catagory.default(@jas.id)
      c.id.should == 0
      c.name.should == '默认分类'
      c.user_id.should == @jas.id
      c.new_record?.should == true
    end
  end
end
