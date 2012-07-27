# encoding: UTF-8
module JLogin
  private
  #把session的值设成对应的@变量，方便v层使用
  def check_session
    @logined = session[:logined].nil? ? false : true
    @user_id = @logined ? session[:user_id] : nil
    @user_name = @logined ? session[:user_name] : nil
    @user_nickname = @user_name
    @user_email = @logined ? session[:user_email] : nil
    @blog_name = session[:blog_name]
    @admin = session[:admin] ? true : false
  end

  #登录的时候设置一些session
  def set_session(user)
    session[:logined] = true
    session[:user_id] = user.id
    session[:user_email] = user.email
    session[:user_name] = user.nickname || user.name
    session[:blog_name] = (user.setting.blog_name.blank?)? "#{session[:user_name]}的博客" : user.setting.blog_name
    session[:admin] = admin?(user)
  end

  def update_session
  end

  #用于logout时候清除session
  def clear_session
    session.clear
  end

  #检查用户是否登录，未登录则去错误页面
  def check_login
    if session[:user_id].blank?
      flash[:notice] = '用户未登录'
      redirect_to(controller:'Error', action:'nonelogin')
    end
  end

  #用在index和show里头判断对比session和提交id是否owner, 增加@owner
  def check_owner(user)
    @owner = (user.id == @user_id) ? true : false
  end

  private
  def admin?(user)
    user.email.in? Admin.jconfig.admin
  end
end
