# encoding: UTF-8
class ArticlesController < ApplicationController
  layout "article"
  before_filter :check_login, :only => [:edit, :create, :new, :update, :destroy]   
  before_filter :check_session

  def index
    @articles = Article.get_index(params[:user_id] || @user_id)
    set_catagories(params[:user_id] || @user_id)
  end

  def new
    @article = Article.new(user_id:session[:user_id])
    @catagories = Catagory.get_all(@user_id)
  end

  def create
    @a = Article.new(params[:article])
    @a.user_id = @user_id
    redirect_to articles_path, method:'get' if @a.save
  end

  def edit
    @article = Article.find_by_id(params[:id])
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
    set_catagories(@article.user_id)
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
