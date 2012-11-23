# encoding: UTF-8
class ArticlesController < ApplicationController
  layout "article"
  before_filter :check_login, :only => [:edit, :create, :new, :update, :destroy]   
  before_filter :check_session
  before_filter {|c| c.set_breadcrumbs}
  before_filter :init_params, :only => [:create, :update]
  # TODO: 文章图片(初步完成 添加 删除 ajax滚动读取)
  # TODO: markdown提示
  # TODO: preview 滚动问题
  # TODO: demo完善
  # TODO: 分页
  # TODO: catagory重构删除加data-confirm
  # TODO: preview显示添加的图片的时候可以remove走同时 remove掉 textarea里面的链接
  # TODO: page model controller view 更加细化
  # TODO: 删减一下bootstrap css里面用不到的东西例如图标自体那些
  # TODO: 美化article_index 分页导航
  # TODO: 增加回复别人评论时候notify一下的功能，要大修了, 还有全站ajax获取有没有新notify
  # TODO: notify画面可以直接回复
  # TODO: 关注用户，用户更新有notify功能
  # TODO: ssl通道, 上线后再处理
  # TODO: 每个blog要有加banner功能
  # TODO: 头像可切割
  # TODO: 文章追加功能
  # TODO: 小工具， todo list
  # TODO: 草稿功能能保存到服务器
  # TODO: 模板功能
  
  def index
    params[:user_id] = @user_id if params[:user_id].blank?
    @current_user = User.get_user(params)
    unless @current_user
      flash[:error] = "没有这个用户"
      redirect_to root_path
    end
    @articles = Article.get_index(@current_user.id, params[:page])
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
      cookies[:create_article] = @article.id 
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
      cookies[:update_article] = @article.id
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
    respond_to do|format|
      format.html
      format.json {render json:@article.to_json }
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if check_owner(@article.user)
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url }
        format.json { head :ok }
      end
    else
      flash[:error]= '当前用户没有权限删除！'
      redirect_to root_path
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
