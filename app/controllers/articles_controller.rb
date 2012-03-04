class ArticlesController < ApplicationController
  before_filter :check_session

  def index
    p "logined:#{@logined}"
    p "user_id:#{@user_id}"
    if @logined
      @articles = Article.where("user_id = ?",@user_id).order("created_at desc");
    else
      flash[:notice] = 'fuck off'
    end
  end

  def new
    @article = Article.new
  end

  def create()
    @a = Article.new(params[:article])
    @a.user_id = session[:user_id]
    unless params[:for_tags].blank?
      t = Tag.find_by_name(params[:for_tags].strip)
      if t.blank?
        t = Tag.create(name:params[:for_tags].strip)
      end
        ArticleTagship.create(article:@a, tag:t)
    end
    redirect_to articles_path, method:'get' if @a.save
  end

  def show()
    if !@user_id.blank?
        @article = Article.includes(:tags).find(params[:id])
    else
        redirect_to controller:'error', action:'login' 
    end
  end

  private
  def check_session
    @logined = session[:logined].nil? ? false : true
    @user_id = @logined ? session[:user_id] : nil
  end
end
