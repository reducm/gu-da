#encoding: UTF-8
class BlogController < ApplicationController
  def index
    @user = User.new
    redirect_to articles_path if session[:logined]
  end

  def logout
    clear_session
    flash[:notice] = '注销成功'
    redirect_to action: 'index'
  end
end
