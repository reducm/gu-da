#encoding: UTF-8
require 'spec_helper'

describe Article do
  before(:all) do
    @article = FactoryGirl.build(:article) 
  end

  context "model CURD" do
    it "test save" do
      @article.save.should be_true
      @article.new_record?.should be_false
    end

    it "get_index" do
    end

    it "fake catagory" do
      @article.catagory.id.should == 0
      @article.catagory.name.should == '默认分类'
      @article.catagory_id.should == 0
    end
  end
end
