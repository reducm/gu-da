# encoding: utf-8
class CatagoriesController < ApplicationController
  before_filter :check_login, :only => [:create, :destroy, :update] 
  before_filter :check_session


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
      render :json => Catagory.get_all(@user_id).to_json
    else
      render :json => {errors:"删除失败"}
    end
  end

  def update
  end
end
