#encoding: utf-8
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
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
      set_session(@user)  
      redirect_to articles_url, :method => 'get' 
    else
      flash[:notice] = @user.jerrors
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
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
    if @user.blank?
      flash[:notice] = 'login error' 
      redirect_to :controller => 'blog', :action => 'index'   
    else
      session[:logined] = true
      session[:user_id] = @user.id
      redirect_to articles_url, :method => :get 
    end
  end
end
