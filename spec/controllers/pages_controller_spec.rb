require 'spec_helper'

describe PagesController do
  render_views
  before(:each) do
    @jas = FactoryGirl.create :jas   
    10.times{|i| FactoryGirl.create :page}
    @page = Page.first
  end

  describe "action" do
    it "index" do
      get :index
      response.should redirect_to @page
    end
    
  end
end
