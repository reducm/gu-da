# encoding: UTF-8
module JBreadcrumbs
protected
  def set_breadcrumbs(controller_title=nil)
    home_link = "<a href=\"/\">HOME</a>"
    @breadcrumbs = [home_link.html_safe]
    @breadcrumbs << "<a href=\"#{url_for}\">#{controller_title}</a>".html_safe if controller_title != nil
  end

  def set_page_title(page_title)
    @page_title = page_title
    unless @page_title.blank?
      @breadcrumbs << "<a href=\"#{url_for}\">#{@page_title}</a>".html_safe
    else
      nil
    end
  end

end
