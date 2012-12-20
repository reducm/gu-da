require 'spec_helper'
require 'rspec/mocks'

describe ArticlesController do
  render_views
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
      assigns(:user_id).should == @user.id

      get :index, {user_id:@user.id}, format: :atom
      should respond_with(:success)
    end
   
    it "new" do
      get :new
      should assign_to :article
      should assign_to :current_user
      should assign_to :catagories
      should assign_to :breadcrumbs
    end

    it "edit" do
      get :edit, id: @user.articles.first.id
      should respond_with :success
      should render_template("edit")
      should assign_to :article
      should assign_to :catagories
      should assign_to :current_user
    end

    it "create" do
      Article.any_instance.stub(:save).and_return(true)
      Article.any_instance.stub(:id).and_return(1)
      post :create, article:{title:'hello', content:'helloworld!'}
      should respond_with :redirect
      cookies[:create_article] == assigns(:article).id
    end

    it "create fail" do
      Article.any_instance.stub(:save).and_return(false)
      post :create, article:{title:'hello', content:'helloworld!'}
      should respond_with :success
      flash.should_not be_nil
      should render_template("new")
    end

    it "update success" do
      article = FactoryGirl.create(:article)
      put :update, id:article.id, article:{title:'hello',content:'hello world'}
      assigns(:article).title.should == 'hello'
      assigns(:article).content.should == 'hello world'
      assigns(:article).new_record?.should be_false
      flash.should_not be_nil
      should respond_with :redirect
      cookies[:update_article].should == article.id
    end

    it "update fail" do
      article = FactoryGirl.create(:article)
      put :update, id:article.id, article:{title:''}
      assigns(:article).errors.any?.should_not be_nil
      flash.should_not be_nil
      should respond_with :success
      should render_template "edit"
    end

    it "destroy success" do
      controller.should_receive(:check_owner).and_return(true)
      article = FactoryGirl.create(:article)
      article.id.should_not be_nil
      delete :destroy, id:article.id
      flash[:error].should be_nil
      expect {Article.find(article.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "destroy fail" do
      controller.should_receive(:check_owner).and_return(false)
      article = FactoryGirl.create(:article)
      article.id.should_not be_nil
      delete :destroy, id:article.id
      flash[:error].should_not be_nil
      article.id.should_not be_nil
    end

    it "demonew with none login user" do
      get :demonew
      should respond_with :success
      should render_template("new")
      should assign_to :article
      should assign_to :catagories
      should assign_to :current_user
    end

    it "demo with login user" do
      session[:user_id] = @user.id
      get :demonew
      should respond_with :success
      should render_template("new")
      should assign_to :article
      should assign_to :catagories
      should assign_to :current_user
      assigns(:current_user).id.should == @user.id
    end
  end
end
