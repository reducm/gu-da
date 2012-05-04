# encoding: utf-8
class CatagoriesController < ApplicationController
  before_filter :check_login, :only => [:create, :destroy, :update] 
  before_filter :check_session


  def create
    @catagory = Catagory.create(params[:catagory])
    if @catagory.errors.any?
      render :json => {errors:"#{@catagory.jerrors}"}
    else
      render :json => Catagory.find_all_by_user_id(@user_id).to_json
    end
  end
  
  def destroy
    if Catagory.destroy(params[:id])
      redirect_to request.url
    else
      flash[:notic] = '删除错误'
      redirect_to :controller => 'error', :action => 'error'   
    end
  end

  def update
  end
end
