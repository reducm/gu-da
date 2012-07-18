# encoding: utf-8
class CatagoriesController < ApplicationController
  layout 'article'
  before_filter :check_login, :only => [:create, :destroy, :update] 
  before_filter :check_session
  before_filter :set_breadcrumbs
  before_filter {|c|c.set_breadcrumbs '分类'}

  def show
    if (params[:id] == '0' || params[:id] == nil) && !(params[:user_id].blank?)
      @articles = Article.where("user_id=? and catagory_id=0", params[:user_id]).all
    else
      @articles = Article.where("catagory_id=?", params[:id])
    end
    @current_user = User.find(@articles[0].user_id) if @articles.size > 0
    @catagories = @articles.size > 0 ? Catagory.get_all(params[:user_id] || @articles[0].user_id) : nil
    title = ((params[:id]=='0') ? "默认分类" : Catagory.find(params[:id]).name)
    set_page_title("分类:#{title}", @current_user)
    render :template => 'articles/index'
  end

  def create
    @catagory = Catagory.create(params[:catagory])
    if @catagory.errors.any?
      render :json => {errors:"#{@catagory.jerrors}"}
    else
      render :json => Catagory.get_all(@user_id).to_json
    end
  end
  
  def destroy
    if Catagory.destroy(params[:id])
      Article.where("catagory_id=?", params[:id]).update_all(:catagory_id=>0)
      render :json => Catagory.get_all(@user_id).to_json
    else
      render :json => {errors:"删除失败"}
    end
  end

  def update
  end
end
