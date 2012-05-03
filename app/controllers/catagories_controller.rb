class CatagoriesController < ApplicationController
  before_filter :check_login, :only => [:create, :destroy, :update] 

  def create
    @catagory = Catagory.create(params[:catagory])
    if @catagory.errors.any?
      render :json => {errors:"#{@catagory.jerrors}"}
    else
      render :json => Catagory.find_all_by_user_id(@user_id).to_json
    end
  end
  
  def destroy
  end

  def update
  end
end
