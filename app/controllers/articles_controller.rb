# encoding: UTF-8
class ArticlesController < ApplicationController
  layout "article"
  before_filter :check_login, :only => [:edit, :create, :new, :update, :destroy]   
  before_filter :check_session
  before_filter {|c| c.set_breadcrumbs '博客'}

  def index
    @articles = Article.get_index(params[:user_id] || @user_id)
    set_catagories(params[:user_id] || @user_id)
    check_owner(params[:user_id] || @user_id)
  end

  def new
    @article = Article.new(user_id:session[:user_id])
    @catagories = Catagory.get_all(@user_id)
    set_page_title '新建文章'
  end

  def create
    @a = Article.new(params[:article])
    @a.user_id = @user_id
    redirect_to articles_path, method:'get' if @a.save
  end

  def edit
    @article = Article.find_by_id(params[:id])
    @catagories = Catagory.get_all(@user_id)
    set_page_title "修改文章|#{@article.title}"
  end

  def update
    @article = Article.find_by_id(params[:id])
    if @article.update_attributes(params[:article])
      redirect_to @article, notice: '编辑成功'
    else
      render :action => 'edit' 
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = Comment.get_by_article_id(params[:id])
    set_catagories(@article.user_id)
    set_page_title @article.title
    check_owner @article.user_id
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :ok }
    end
  end

  protected
  def set_catagories(user_id)
    @catagories = Catagory.get_all(user_id)
  end
end
