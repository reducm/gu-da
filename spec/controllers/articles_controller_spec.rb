require 'spec_helper'
require 'rspec/mocks'

describe ArticlesController do
  render_views
  before(:each) do
    @user = FactoryGirl.create(:jas)
    15.times{|i| FactoryGirl.create(:article, user: @user)}
    @articles = @user.articles
    session[:user_id] = @user.id
  end

  describe "index" do
    it "get" do
      get :index, {user_id:@user.id, page:1}
      response.code.should eq('200')
      should respond_with(:success)
      should render_template("index")
      assigns(:articles).size.should == 10
    end

    it "should redirect when no current user" do
      get :index, {user_id:1000}
      response.should redirect_to root_path
    end

    it "atom" do
      session[:user_id] = @user.id
      get :index, {user_id:@user.id}, format: :atom
      should respond_with(:success)
    end

    it "show" do
      old_visit = @articles.first.visit
      get :show, {id: @articles.first.id}
      should respond_with :success
      @articles.first.visit.should == old_visit + 1
    end
   
    it "new" do
      get :new
      should render_template :new
    end

    it "create" do
      post :create, {article:{user_id: @user.id, content: "blah", title:"shit" }}
      should respond_with :success
      should set_the_flash
    end

    it "edit" do
      get :edit, id: @user.articles.first.id
      should respond_with :success
      should render_template("edit")
    end

    it "create fail" do
      post :create, article:{title:'hello', content:'helloworld!'}
      should render_template :new
      flash[:error].should_not be_nil
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
    end

    it "demo with login user" do
      session[:user_id] = @user.id
      get :demonew
      should respond_with :success
      should render_template("new")
      assigns(:current_user).id.should == @user.id
    end
  end
end
