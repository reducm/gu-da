class BlogController < ApplicationController
  def index
    redirect_to articles_path if session[:logined]
    @user = User.new
  end

  def logout
    clear_session
    flash[:notice] = '注销成功'
    redirect_to :action => 'index'
  end
end
