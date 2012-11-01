#encoding: utf-8
class UsersController < ApplicationController
  before_filter :check_login, only: [:edit, :update, :destroy] 
  before_filter :check_session

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    redirect_to user_articles_path((params[:id] || params[:nickname])) 
  end

  def new
    if params[:user].blank?
      @user = User.new
    else
      @user = User.new(params[:user])
      @user.valid?
    end
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @user = User.new(params[:user])
    @title = "用户注册"
    render_to = 'new'
    if params[:user][:authentications]
      @a = Authentication.find(params[:user][:authentications])
      render_to = 'authentications/new'
    end

    @user.valid? 
    if @user.password != @user.password_confirm
      @user.errors[:password] << '密码确认与密码不相符'
      render render_to
      return
    elsif @user.password.length < 6 or @user.password.length >20
      @user.errors[:password] << '密码长度在6-20之间'
      render render_to
      return
    end

    if @user.save
      @user.authentications << @a if @a
      set_session(@user)
      session[:signup_new] = true
      redirect_to articles_url, method: 'get' 
    else
      #flash[:notice] = @user.jerrors
      render render_to
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "#{@user.name} 用户设置"
    render layout: "acount_setting"
  end

  def update
    (@user = User.new(params[:user])) && (flash[:notice] = "非法修改数据!") && (render :edit, layout:"acount_setting") if @user_id != params[:id].to_i
    params.delete :email
    @user = User.updates params[:user],params[:id]
    unless @user.errors.any?
      flash[:notice] ='用户更新成功'
      redirect_to edit_user_path(@user)
    else
      flash[:error] = @user.jerrors
      render :edit, layout: "acount_setting"
    end
    #if params[:user][:password_new] != params[:user][:password_confirm]
      #flash[:notice] = '两次输入密码不相同'
      #render :edit, layout: "acount_setting"
      #return
    #end

    #@user = (params[:user][:password].blank?)? User.updates_nopass(params[:user], params[:id]) : User.updates(params[:user], params[:id])
    #if @user.errors.any?
      #flash[:error] = @user.jerrors
      #render :edit, layout: "acount_setting"
      #return
    #else
      #flash[:notice] = '用户更新成功'
      #set_session(@user)
      #redirect_to edit_user_url(@user_id) 
    #end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  def login
    @user = User.check(params[:user])
    if @user.jerrors
      flash[:notice] = @user.jerrors
      redirect_to controller: 'blog', action: 'index'   
    else
      @setting = @user.setting
      set_session(@user)
      redirect_to articles_url, method: :get 
    end
  end
end
