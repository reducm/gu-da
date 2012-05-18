# encoding: utf-8
class CatagoriesController < ApplicationController
  before_filter :check_login, :only => [:create, :destroy, :update] 
  before_filter :check_session

  def show
    if params[:id] == 0 || params[:id] == nil
      @catagory.new(name:'未分类', user_id:0)
    end
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
