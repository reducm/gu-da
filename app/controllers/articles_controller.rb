class ArticlesController < ApplicationController
  before_filter :check_session

  def index
    if @logined
      @articles = Article.where("user_id = ?",@user_id).order("created_at desc");
    else
      flash[:notice] = 'fuck off'
    end
  end

  def new
    @article = Article.new(user_id:session[:user_id])
  end

  def create
    @a = Article.new(params[:article])
    @a.user_id = @user_id
    unless params[:for_tags].blank?
      t = Tag.find_by_name(params[:for_tags].strip)
      if t.blank?
        t = Tag.create(name:params[:for_tags].strip)
      end
      ArticleTagship.create(article:@a, tag:t)
    end
    redirect_to articles_path, method:'get' if @a.save
  end

  def edit
    @article = Article.find_by_id(params[:id])
  end

  def show
    if !@user_id.blank?
      @article = Article.includes(:tags).find(params[:id])
    else
      redirect_to controller:'error', action:'login' 
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :ok }
    end
  end
end
