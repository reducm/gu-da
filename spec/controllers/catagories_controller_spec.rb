require 'spec_helper'
require 'rspec/mocks'

describe CatagoriesController do
  render_views
  before(:each) do
    @jas = FactoryGirl.create(:jas)
    @user = FactoryGirl.create(:user)
    @catagory = FactoryGirl.create(:catagory, user:@jas)
    10.times {FactoryGirl.create(:article,user:@jas, catagory:@catagory)}
    session[:user_id] = @jas.id
  end

  describe "controller action" do
    it "show with user_id" do
      get 'show', id:@catagory.id, user_id:@jas.id
      assigns(:articles).size.should == 10
      assigns(:current_user).id.should == @jas.id
      assigns(:catagories).size.should == 2
      should render_template("articles/index")
    end

    it "show with no article" do
      get 'show', id:0, user_id:@user.id
      should respond_with(:success)
      assigns(:articles).size.should == 0
      
    end

    it "create success" do
      Catagory.stub(:get_all).and_return(Catagory.where(user_id: @jas.id))
      post :create, catagory:{name:'hello', user_id:@jas.id}
      json = JSON.parse(response.body)
      json.size.should == 2
      json[1]["name"].should == 'hello'
    end
  end
end
