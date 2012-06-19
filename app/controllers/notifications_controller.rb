class NotificationsController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  def index
    @notifications = Notification.get_all(params[:user_id])
    render :layout => 'acount_setting'
  end

  def show
  end

  def destroy
  end
end
