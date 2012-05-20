#encoding: utf-8
module ArticlesHelper
  def catagory_sidebar
    unless params[:action] == 'edit' || params[:action] == 'new'
      render 'layouts/catagory', :catagories => @catagories, :user_id => @user_id
    else
      nil
    end
  end

  def catagory_sidebar_list(catagories)
    str = ""
    catagories.each do |c|
      a = ""
      d = ""
      if c.id == nil || c.id == 0
        a = link_to c.name, "#{catagory_path(0)}?user_id=#{c.user_id}"
        d = nil
      else
        a = link_to c.name, catagory_path(c)
        d = link_to "x", catagory_path(c), :method => 'delete', :remote => true 
      end
      str += "<h3>#{a} #{d}</h3>"
    end
    str.html_safe
  end

  def article_width_height
    if params[:action] == 'edit' || params[:action] == 'new'
      "style=width:94%;height:760px"
    else
      nil
    end
  end

  def page_title_helper
    if @page_title.blank?
      "咕哒网"
    else
      "#{@page_title} | 咕哒网"
    end
  end
end
