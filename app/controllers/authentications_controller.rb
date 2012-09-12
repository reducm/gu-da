require_dependency 'jas/jshare'
class AuthenticationsController < ApplicationController
  include JShare
  before_filter :check_session
  #before_filter :check_login

  def index
    flash[:notice] = params[:message] unless params[:message].blank?
    @authentications = Authentication.get_all(@user_id)
    @authentication_hash = {}
    @authentications.each do |a|
      atr = a.attributes
      @authentication_hash[a['provider']] = atr
    end
    @authentications = nil
    @authentication_hash
    render :layout => 'acount_setting'
  end

  def new
    @user = User.first
    @a = Authentication.first
    render :layout => 'application'
  end

  def create
    renv = request.env["omniauth.auth"]
    atoken = renv["credentials"].token
    asecret = request.env["omniauth.auth"]["credentials"].secret
    if @user_id
      #已登录，新绑定的情况或更新信息，跳转到创建文章或者更新文章的session，或者跳回绑定设置页面
      @a = Authentication.find_or_create(@user_id, renv)
      if session[:create_article] || session[:update_article]
        redirect_to user_article_path(@user_id, session[:create_article] || session[:update_article])
      else
        redirect_to user_authentications_path(@user_id)
      end
    else
      #未登录情况
      @a = Authentication.find_by_uid_and_provider(renv.uid, renv.provider) 
      if @a && @a.user_id != 0
        #找到认证的，就让关联好的user登录
        @a.update_from_request(renv)
        @user = @a.user
        set_session(@user)
        redirect_to user_path(@user)
      else
        #找不到认证的，就render去new让他绑定已有用户或者创建用户
        if @a
          @a = @a.valid? ? @a : Authentication.create_temp_from_request(renv)
        else
          @a = Authentication.create_temp_from_request(renv)
        end
        # TODO: 做到生成的user form hidden里面有问题
        @user = User.new
        binding.pry
        render :template => 'authentications/new'
      end    
    end
=begin
  if @user_id
    #新绑定的情况或更新信息
    find_or_create(env)
  else
    #用于登录或者创建用户的情况
    login_or_create_user
=end
  end

  def share
    session[:create_article], session[:update_article] = false, false
    share_to(Article.find(params['article']),params['providers'])
  end
end
