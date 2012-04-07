# encoding: UTF-8
module JLogin
  private
  def check_session
    @logined = session[:logined].nil? ? false : true
    @user_id = @logined ? session[:user_id] : nil
  end

  def set_session(user)
    session[:logined] = true
    session[:user_id] = user.id
    session[:user_name] = user.name
  end

  def check_login
    unless session[:user_id]
      flash[:notice] = '用户未登录'
      redirect_to(controller:'Error', action:'nonelogin')
    end
  end
end
