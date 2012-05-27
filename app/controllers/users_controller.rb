#encoding: utf-8
class UsersController < ApplicationController
  before_filter :check_login, :only => [:edit, :update, :destroy] 
  before_filter :check_session

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id] || params[:name])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = params[:user].blank? ? User.new : User.new(params[:user])
    flash[:notice] = @user.jerrors unless @user.valid?
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "(#{@user.name})用户设置"
  end

  def create
    @user = User.new(params[:user])
    @title = "用户注册"
    if @user.password != @user.password_confirm
      flash[:notice] = '密码确认与密码不相符'
      render :new
      return
    elsif @user.password.length < 6 or @user.password.length >20
      flash[:notice] = '密码长度在6-20之间'
      render :new
      return
    end

    if @user.save
      @setting = Setting.create(:user => @user )
      set_session(@user)
      redirect_to articles_url, :method => 'get' 
    else
      #flash[:notice] = @user.jerrors
      render :new
    end
  end

  def update
    @user = User.find_by_name(@user_name)
    if params[:user][:password_new] != params[:user][:password_confirm]
      flash[:notice] = '两次输入密码不相同'
      render :edit
      return
    end
  
    @user = (params[:user][:password].blank?)? User.updates_nopass(params[:user], params[:id]) : User.updates(params[:user], params[:id])
    if @user.errors.any?
      flash[:notice] = @user.jerrors
      render :edit
      return
    else
      flash[:notice] = '用户更新成功'
      set_session(@user)
      render :edit
    end
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
      redirect_to :controller => 'blog', :action => 'index'   
    else
      @setting = @user.setting
      set_session(@user)
      redirect_to articles_url, :method => :get 
    end
  end
end
