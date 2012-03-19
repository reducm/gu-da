module JLogin
  private
  def check_session
    @logined = session[:logined].nil? ? false : true
    @user_id = @logined ? session[:user_id] : nil
  end

  def set_session(user)
    session[:logined] = true
    session[:user_id] = user.id
  end
end
