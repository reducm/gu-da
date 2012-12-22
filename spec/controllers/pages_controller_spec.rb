require 'spec_helper'

describe PagesController do
  render_views
  before(:each) do
    @jas = FactoryGirl.create :jas   
    2.times{|i|
      FactoryGirl.create :page
    }
    @page = Page.first
    session[:user_id] = @jas.id
    session[:admin] = true
  end

  describe "action" do
    it "index" do
      get :index
      response.should redirect_to @page
    end

    it "show" do
      get :show
      should assign_to :pages
      should assign_to :page
      should assign_to :page_title
    end

    it "new" do
      get :new
      assigns(:page).should_not be_nil
    end

    it "new not admin" do
      session[:admin] = false
      get :new
      should respond_with :redirect
    end

    it "edit" do
      get :edit, id: @page.id
      should respond_with :success
      should assign_to :page
    end

    it "edit not admin" do
      session[:admin] = false
      get :edit, id: @page.id
      should respond_with :redirect
    end
 
  end
end
