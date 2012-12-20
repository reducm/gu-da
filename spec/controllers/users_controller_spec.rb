require 'spec_helper'
require 'rspec/mocks'

describe UsersController do
  render_views
  before(:each) do
    @user = FactoryGirl.create(:jas)
    15.times{|i| FactoryGirl.create(:article, user: @user)}
    @articles = @user.articles
    session[:user_id] = @user.id
  end

  describe "action" do
    it "index" do
      get :index, format: :json
      result = JSON.parse(response.body)
      result.first["id"].should == @user.id
    end

    it "show" do
      get :show, id: @user.id
      response.should redirect_to user_articles_path @user
    end

    it "update" do
      put :update, {id:@user.id, user:{nickname:"new_shit"} }
      should respond_with :redirect
      assigns(:user).nickname.should == "new_shit"
    end
  end
end
