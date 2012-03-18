module JLogin
  private
  def check_session
    @logined = session[:logined].nil? ? false : true
    @user_id = @logined ? session[:user_id] : nil
  end
end
