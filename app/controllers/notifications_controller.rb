#encoding: utf-8
class NotificationsController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  def index
    flash[:notice] = 'test'
    @notifications = Notification.get_all(params[:user_id])
    render :layout => 'acount_setting'
  end

  def show
  end

  def destroy
    n = Notification.delete(params[:id])
    flash[:error] = '删除失败' if n == 0
    redirect_to user_notifications_path(@user_id)
  end
end
