# encoding: utf-8
class CatagoriesController < ApplicationController
  layout 'article'
  before_filter :check_login, only: [:create, :destroy, :update] 
  before_filter :check_session
  before_filter :set_breadcrumbs
  before_filter {|c|c.set_breadcrumbs '分类'}

  def show
    @articles = Article.catagory_index(params[:user_id], params[:id], params[:page])
    @current_user = User.find(params[:user_id])
    @catagories = Catagory.get_all(params[:user_id])
    title = ((params[:id]=='0') ? "默认分类" : Catagory.find(params[:id]).name)
    set_page_title("分类:#{title}", @current_user)
    render template: 'articles/index'
  end

  def create
    params.delete(:id)
    @catagory = Catagory.create(catagory_params)
    if @catagory.errors.any?
      render json: {errors:"#{@catagory.jerrors}"}
    else
      render json: Catagory.get_all(session[:user_id]).to_json
    end
  end
  
  def destroy
    if Catagory.destroy(params[:id])
      Article.where("catagory_id=?", params[:id]).update_all(catagory_id:0)
      render json: Catagory.get_all(session[:user_id]).to_json
    else
      render json: {errors:"删除失败"}
    end
  end

  def update
  end

  protected
  def catagory_params
    params.require(:catagory).permit(:user_id, :name, :pid, :id)
  end
end
