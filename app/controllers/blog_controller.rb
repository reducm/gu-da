class BlogController < ApplicationController
  def index
    redirect_to articles_path if session[:logined]
    @user = User.new
  end

  def logout
    session[:logined] = false
    session[:user_id] = nil
    flash[:notice] = 'successful logout'
    redirect_to :action => 'index'
  end
end
