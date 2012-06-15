class NotificationsController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  def index
    render :layout => 'acount_setting'
  end
  
  def show
  end

  def destroy
  end
end
