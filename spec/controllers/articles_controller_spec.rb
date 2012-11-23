require 'spec_helper'

describe ArticlesController do
  let!(:user) {FactoryGirl.create :jas}
  let!(:artilces) {15.times{FactoryGirl.create :article, user:user}}

  context "index" do
    it "get" do
      get "index", {user_id:user.id, page:1}
      response.code.should eq('200')
      response.should render_template("index")
      assigns(:catagories).should_not be_nil
      assigns(:articles).size.should == 10
      assigns(:current_user).should_not be_nil
    end
  end

  context "anonymous user" do
     it "anonymous couldn't create" do
       expect{
         post 'create', article:{title:'hello', content:'content', user_id: user.id}
       }.to_not change(Article)
     end
  end
end
