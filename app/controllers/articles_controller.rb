class ArticlesController < ApplicationController
  before_filter :check_session

  def index
    p "logined:#{@logined}"
    p "user_id:#{@user_id}"
    if @logined
      @articles = User.find(@user_id).articles
    else
      flash[:notice] = 'fuck off'
    end
  end

  private
  def check_session
    @logined = session[:logined].nil? ? false : true
    @user_id = @logined ? session[:user_id] : nil
  end
end
