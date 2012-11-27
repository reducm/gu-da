require 'spec_helper'

describe CommentsController do
  before(:each) do
    @jas = FactoryGirl.create :jas
    @article = FactoryGirl.create :article, user:@jas
  end
  
  context "action" do
    it "create with user" do
      post :create, comment:{content:'hello', user_id:@jas.id, article_id:@article.id}   
      result = JSON.parse(response.body)
      p result
      result['strtime'].should_not be_nil
      result['user_name'].should_not be_nil
      result['user_id'].should_not == 0
    end

    it "create with guest" do
      post :create, comment:{content:'hello', article_id:@article.id, visitor_name:'aaaa', visitor_email:'shit@shit.com'}   
      result = JSON.parse(response.body)
      p result
      result['strtime'].should_not be_nil
      result['user_name'].should_not be_nil
      result['user_name'].should == result['visitor_name']
      result['user_id'].should == 0
    end
  end
end
