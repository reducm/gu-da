class NotificationsController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  def index
    @notifications = Notification.includes(:senderable => [:article,:user]).where("receiver_id=?", params[:user_id]).all
    render :layout => 'acount_setting'
  end
  
  def show
  end

  def destroy
  end
end
