require 'spec_helper'

describe Comment do
  before(:each) do
    @jas = FactoryGirl.create :jas
    @user = FactoryGirl.create :user
    @article = FactoryGirl.create :article, user:@jas
    10.times{FactoryGirl.create :comment, user:@user, article:@article}
    10.times{FactoryGirl.create :anonymous_comment, article:@article}
  end

  context "class function" do
    it "get_by_article_id" do
      cs = Comment.get_by_article_id(@article.id)
      cs.size.should == 20
    end

    it "get_user_name with sign up user" do
      c = FactoryGirl.create :comment, user:@jas, article:@article, content:'content'
      c.new_record?.should be_false
      c.get_user_name.should == 'jas'
      c.visitor_name.should be_nil
      c.visitor_email.should be_nil
    end

    it "get_user_name with guest" do
      c = FactoryGirl.create :comment, visitor_name:'hello', visitor_email:'shit@shit.com', article:@article, content:'content'
      c.new_record?.should be_false
      c.get_user_name.should == 'hello'
      c.visitor_name.should_not be_nil
      c.visitor_email.should_not be_nil
    end

    it "to_json should has key user_head" do
      @jas.setting.picture = Picture.new(file:File.open("#{Rails.root}/app/assets/images/rails.png"))
      @jas.setting.picture.save
      @jas.reload
      c = FactoryGirl.create :comment, user:@jas, article:@article, content:'content'
      c_json = JSON.parse c.to_json
      p c_json
      c_json.should  have_key "user_head"
    end
  end
end
