class AdminsController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  before_filter :check_admin
  layout 'acount_setting'

  def index
    @user = User.find(@user_id) 
    @pages = Page.select("id, title, subtitle").all
  end
end
