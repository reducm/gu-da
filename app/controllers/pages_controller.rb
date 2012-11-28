#encoding: UTF-8
class PagesController < ApplicationController
  layout :resolve_layout
  before_filter :check_login
  before_filter :check_session
  before_filter :check_admin, only:[:new, :create, :edit, :update, :destroy]
  before_filter {|c| c.set_breadcrumbs}
  # TODO: 暂时先手动添加jquery ui, 以后要自己把jqueryui做成gem模式并且可以自定义载入模块 
  def index
    redirect_to action:'show', id:1
  end

  def show
    params[:id] ||= 1
    @pages = Page.get_all
    @page = Page.by_id(params[:id])
    set_page_title(@page.title) if @page
  end

  def new
    @page = Page.new
    set_page_title("管理员:创建页面")
  end

  def create
    @page = Page.create(params[:page])
    if @page.errors.any?
      flash[:error] = @page.jerrors
      render :new
    else
      redirect_to action:'show', id:@page.subtitle
    end
  end

  def edit
    @page = Page.find(params[:id])
    set_page_title("管理员:编辑页面")
  end

  def update
    @page = Page.find_by_id(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to @page, notice: '编辑成功'
    else
      flash[:error] = @page.jerrors
      render action:'edit'
    end
  end

  def destroy
    @page = Page.find_by_id(params[:id])
    @page.destroy
    redirect_to admins_path()
  end

  private
  def resolve_layout
    case action_name
    when "new", "edit"
      "article"
    when "index", "show"
      "acount_setting"
    else
      "application"
    end
  end
end
