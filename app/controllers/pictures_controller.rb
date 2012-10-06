# encoding: UTF-8
class PicturesController < ApplicationController
  layout false
  before_filter :check_login, :only => [:edit, :create, :new, :update, :destroy] 
  before_filter :check_session
  before_filter :check_admin

  def create
  end

  def update
  end

  def show
  end

  def destroy
    if Picture.destroy(params[:id])
      render json:{message:"删除成功",success:true}
    else
      render json:{errors:"删除picture_#{params[:id]}失败"}
    end
  end
end
