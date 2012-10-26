#encoding: UTF-8
class PagesController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  before_filter :check_admin
  # TODO: 暂时先手动添加jquery ui, 以后要自己把jqueryui做成gem模式并且可以自定义载入模块 
  def update
    binding.pry
    page = params[:page] || params
    if page[:title] == 'index_images' && page[:pictures]
      @page = Page.find_or_create(page)
      Page.transaction do
        page[:pictures].each do|number, picture|
          @page.pictures << Picture.new(file:picture) 
        end
        @page.save
      end
      render json: @page.to_json(include: [pictures:{only: [:id, :file]}])
    else
      render json: {message:"message"}
    end
  end

end
