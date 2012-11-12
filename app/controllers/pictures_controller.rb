# encoding: UTF-8
class PicturesController < ApplicationController
  before_filter :check_login, only: [:edit, :create, :new, :update, :destroy] 
  before_filter :check_session

  def create
    ps = []
    params[:pictures].each do|key,value|
      picture = Picture.new(file:value, pictureable_type: params[:pictureable_type], pictureable_id: params[:pictureable_id]) 
      picture.save
      ps << picture unless picture.errors.any?  #picture.file.preview.url unless picture.errors.any?
    end
    ps.size > 0 ? (render json: {pictures:ps}) : (render json: {errors:'上传出错了,请检查你的图片符合规范'})
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
  
  def index 
    params[:page] ||= 1
    @pictures = Picture.get_index(params)
    render json: {page: params[:page], pictures:@pictures}
  end
end
