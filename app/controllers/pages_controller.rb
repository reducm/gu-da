class PagesController < ApplicationController
  before_filter :check_login
  before_filter :check_session
  before_filter :check_admin
  
  def create
    page = params[:page]
    binding.pry
    if page[:title] == 'index_images' && page[:pictures]
      @page = Page.find_or_create(page)
      page[:pictures].each do|k,v|
        @page.pictures << Picture.new(file:v) 
      end
      @page.save
      render :json => @page.to_json
    end
  end

  def update
  end
end
