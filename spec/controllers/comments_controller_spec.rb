require 'spec_helper'

describe CommentsController do
  before(:each) do
    @jas = FactoryGirl.create :jas
    @article = FactoryGirl.create :article, user:@jas
    session[:user_id] = @jas.id
  end

  context "action" do
    it "index json keys" do
      10.times{ FactoryGirl.create(:anonymous_comment, article:@article) }
      get :index, article_id:@article.id, format: :json
      result = JSON.parse(response.body)
      result.size.should == 10
      result[0].should have_key("user_head")
      result[0].should have_key("user_name")
      result[0].should have_key("author_id")
    end

    it "create with user" do
      post :create, article_id: @article.id, comment:{content:'hello', user_id:@jas.id, article_id:@article.id}   
      result = JSON.parse(response.body)
      result['strtime'].should_not be_nil
      result['user_name'].should_not be_nil
      result['user_id'].should_not == 0
    end

    it "create with guest" do
      post :create, article_id: @article.id, comment:{content:'hello', article_id:@article.id, visitor_name:'aaaa', visitor_email:'shit@shit.com'}   
      result = JSON.parse(response.body)
      result['strtime'].should_not be_nil
      result['user_name'].should_not be_nil
      result['user_name'].should == result['visitor_name']
      result['user_id'].should == 0
    end

    it "destroy" do
      @comment = FactoryGirl.create(:comment, article:@article,user:@jas,content:"blahblah")
      @comment.article.user_id.should == @jas.id
      delete :destroy, article_id: @article.id, id: @comment.id
      result = JSON.parse(response.body)
      result.should_not have_key("errors")
      #p result
    end
  end
end
