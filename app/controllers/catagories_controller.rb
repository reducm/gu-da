class CatagoriesController < ApplicationController
  before_filter :check_login, :only => [:create, :destroy, :update] 

  def create
    @catagory = Catagory.create(params[:catagory])
    if @catagory.errors.any?
      render :json => Catagory.find_by_user(@user_id).to_json
    else
      render :json => {errors:"#{@catagory.jerrors}"}
    end
  end
  
  def destroy
  end

  def update
  end
end
