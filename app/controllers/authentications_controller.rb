#encoding: UTF-8
require_dependency 'jas/jshare'
class AuthenticationsController < ApplicationController
  include JShare
  before_filter :check_login
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
    #@user = User.new
    #@a = Authentication.first
    #@user.authentications << @a
    render :layout => 'application'
  end

  def create
    renv = request.env["omniauth.auth"]
    atoken = renv["credentials"].token
    asecret = request.env["omniauth.auth"]["credentials"].secret
    if @user_id
      #已登录，新绑定的情况或更新信息，跳转到创建文章或者更新文章的cookies，或者跳回绑定设置页面
      @a = Authentication.find_or_create(@user_id, renv)
      if cookies[:create_article] || cookies[:update_article]
        redirect_to user_article_path(@user_id, cookies[:create_article] || cookies[:update_article])
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
        @user = User.new
        @user.authentications << @a
        #binding.pry
        render :new
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
  
  def destroy
    @authentication = Authentication.find(params[:id])
    if check_owner(@authentication.user)
      @authentication.destroy
      respond_to do |format|
        format.html { redirect_to user_authentications_url(@user_id) }
        format.json { head :ok }
      end
    else
      flash[:error]= '当前用户没有权限删除！'
      redirect_to user_authentications_url(@user_id)
    end

  end

  def share
    #发送失败的话会显示一个出错信息
    share_to(Article.find(params['article']),params['providers']) ? (flash[:notice]= '分享成功') : (flash[:error] = '发送失败,请稍后再试')
    cookies.delete :update_article, path:'/'
    cookies.delete :create_article, path:'/'
    redirect_to user_article_path(@user_id, params['article'])
  end

  def bind
    @user = User.check(params[:user])
    @a = Authentication.find(params[:user][:authentications])
    if @user.jerrors
      flash[:notice] = @user.jerrors
      render :new
    else
      @user.authentications << @a
      @setting = @user.setting
      set_session(@user)
      flash[:notice] = "第三方账号绑定成功！"
      redirect_to articles_url, :method => :get 
    end
  end
end
