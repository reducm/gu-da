#encoding: UTF-8
class BlogController < ApplicationController
  def index
    redirect_to articles_path if session[:logined]
    @user = User.new
    @page = Page.includes(:pictures).find_by_title("index_images")
  end

  def logout
    clear_session
    flash[:notice] = '注销成功'
    redirect_to :action => 'index'
  end
end
