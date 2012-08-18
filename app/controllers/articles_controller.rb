# encoding: UTF-8
class ArticlesController < ApplicationController
  layout "article"
  before_filter :check_login, :only => [:edit, :create, :new, :update, :destroy]   
  before_filter :check_session
  before_filter {|c| c.set_breadcrumbs}
  before_filter :init_params, :only => [:create, :update]

  def index
    params[:user_id] = @user_id if params[:user_id].blank?
    @current_user = User.get_user(params)
    unless @current_user
      flash[:error] = "没有这个用户"
      redirect_to root_path
    end
    @articles = Article.get_index(@current_user.id)
    if session[:signup_new] || @articles.size == 0 #新注册进来产生一些提示操作的变量
      session[:signup_new] = nil
      @signup_new = true
    end
    set_catagories(@current_user.id)
    drop_breadcrumbs {@current_user}
    check_owner(@current_user)
  end

  def new
    @article = Article.new(user_id:session[:user_id])
    @current_user = User.by_id(@user_id)
    set_catagories(@user_id)
    set_page_title '新建文章',@current_user
  end

  def create
    @article = Article.new(params[:article])
    @article.user_id = @user_id
    if @article.save
      @pic = Picture.create(:file => (params[:article][:picture]), :pictureable => @article )
      flash[:notice]='文章创建成功！'
      session[:create_article] = @article.id 
      redirect_to article_path(@article)  
    else
      flash[:error] = "出错了:#{@article.jerrors}"
      set_catagories(@user_id)
      render :new
    end
  end

  def edit
    @article = Article.find_by_id(params[:id])
    @catagories = Catagory.get_all(@user_id)
    @current_user = User.by_id(@user_id)
    set_page_title "修改文章|#{@article.title}", @current_user
  end

  def update
    @article = Article.find_by_id(params[:id])
    if @article.update_attributes(params[:article])
      session[:update_article] = @article.id
      redirect_to @article, notice: '编辑成功'
    else
      render :action => 'edit' 
    end
  end

  def show
    @article = Article.find(params[:id])
    @article.visit_key.increment
    @current_user = User.by_id(@article.user_id)
    @user = User.find(@user_id) if @user_id
    @comment = Comment.new
    @comments = Comment.get_by_article_id(@article.id)
    set_catagories(@article.user_id)
    set_page_title( @article.title, @current_user)
    check_owner @current_user
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :ok }
    end
  end

  def demonew
    @article = Article.new
    @current_user = User.new
    @catagories = Catagory.get_all(@current_user.id)
    set_page_title('Demo')
    render :new
  end

  def demoshow
    render :show
  end

  protected
  def set_catagories(user_id)
    @catagories = Catagory.get_all(user_id)
  end

  def init_params
    params[:article][:catagory_id] = 0 if params[:article][:catagory_id].blank?
  end

  def init_base_breadcumbs
  end
end
