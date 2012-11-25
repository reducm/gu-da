require 'spec_helper'

describe ArticlesController do
  #intergrate_views
  before(:each) do
    @user = FactoryGirl.create(:jas)
    @articles = 15.times{|i| FactoryGirl.create(:article, user: @user)}
    session[:user_id] = @user.id
  end

  describe "index" do
    it "get" do
      get :index, {user_id:@user.id, page:1}
      response.code.should eq('200')
      should respond_with(:success)
      should render_template("index")
      should assign_to(:catagories)
      should assign_to(:current_user)
      assigns(:articles).size.should == 10
    end
   
    it "new" do
      get :new
      should assign_to :article
      should assign_to :current_user
      should assign_to :catagories
      should assign_to :breadcrumbs
    end
  end
end
