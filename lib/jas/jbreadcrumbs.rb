# encoding: UTF-8
module JBreadcrumbs
protected
  def set_breadcrumbs(controller_title=nil)
    #home_link = "<a href=\"/\">HOME</a>"
    @breadcrumbs = []
  end

  def set_page_title(page_title,current_user=nil)
    @page_title = page_title
    unless @page_title.blank?
      drop_breadcrumbs(@page_title,current_user)
    else
      nil
    end
  end

  def drop_breadcrumbs(title=nil, current_user=nil,url=nil)
    url ||= url_for 
    if block_given?
      current_user = yield
    end
    if current_user
      @breadcrumbs << "<a href=\"#{user_articles_path(current_user.id)}\">#{current_user.setting.blog_name || "#{current_user.name}的博客"}</a>".html_safe
    end
    if title
      @breadcrumbs << "<a href=\"#{url}\">#{title}</a>".html_safe
    end
  end
end
