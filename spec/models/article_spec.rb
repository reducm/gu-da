#encoding: UTF-8
require 'spec_helper'

describe Article do
  before(:all) do
    @article = FactoryGirl.build(:article) 
    @user = FactoryGirl.create(:jas)
  end

  describe "method" do
    it "test save" do
      @article.save.should be_true
      @article.new_record?.should be_false
    end

    it "get_index()" do
      15.times{FactoryGirl.create :article, user:@user}
      Article.get_index(@user.id).size.should == 10
      Article.get_index(@user.id, page=1).size.should == 10
      Article.get_index(@user.id, page=2).size.should ==  5
    end

    it "catagory_index" do
      15.times{FactoryGirl.create :article, user:@user}
      Article.catagory_index(@user.id).size.should == 10
      Article.catagory_index(@user.id, 0, 2).size.should == 5
      @catagory  = @user.catagories.create(name:"hello")
      @user.articles.each{|a| a.update_attribute(:catagory_id, @catagory.id)}
      Article.catagory_index(nil, @catagory.id).size.should == 10
      Article.catagory_index(nil, @catagory.id, 2).size.should == 5
      @user.articles.first.catagory.name.should == 'hello'
    end

    it "fake catagory" do
      @article.catagory.id.should == 0
      @article.catagory.name.should == '默认分类'
      @article.catagory_id.should == 0
    end
  end
end
