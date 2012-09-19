class AdminsController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  before_filter :check_admin
  layout ''
  def show
    @user = User.find(params[:id] || @user_id) 
    @pages = Page.get_index
    render :layout => 'acount_setting'
  end
end
