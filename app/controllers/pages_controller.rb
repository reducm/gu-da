#encoding: UTF-8
class PagesController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  before_filter :check_admin
# TODO: 暂时先手动添加jquery ui, 以后要自己把jqueryui做成gem模式并且可以自定义载入模块 
  def update
    page = params[:page]
    if page[:title] == 'index_images' && page[:pictures]
      @page = Page.find_or_create(page)
      page[:pictures].each do|k,v|
        @page.pictures << Picture.new(file:v) 
      end
      @page.save
      render :json => @page.to_json
    end
  end

end
