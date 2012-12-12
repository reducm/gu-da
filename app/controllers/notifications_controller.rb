#encoding: utf-8
class NotificationsController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  def index
    respond_to do|format|
      format.html do
        @notifications = Notification.get_all(params[:user_id])
        render layout: 'acount_setting'
      end
      format.json {render json: {count:Notification.unread_count(params[:user_id]), path:user_notifications_path(params[:user_id])}}
    end
  end

  def show
  end

  def destroy
    n = Notification.delete(params[:id])
    flash[:error] = '删除失败' if n == 0
    redirect_to user_notifications_path(@user_id)
  end
end
