#encoding: utf-8
module ArticlesHelper
  def owner?
    @owner
  end

  def catagory_sidebar
    render :partial => 'layouts/catagory', :locals => { :catagories => @catagories, :user_id => @user_id}
  end

  def user_information_sidebar(user)
    render :partial => 'articles/userinformation', :locals => {:user => user}
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
      str += owner? ? "<h3>#{a} #{d}</h3>" : "<h3>#{a}</h3>"
    end
    str.html_safe
  end

  def article_width_height
    if params[:action] == 'edit' || params[:action] == 'new'
      "class='article_edit_width'"
    else
      "class='article_normal_width'"
    end
  end

  def page_title_helper
    if @page_title.blank?
      "咕哒网"
    else
      "#{@page_title} | 咕哒网"
    end
  end

  def logined?
    @logined
  end

  def show_comments(comments)
    if comments.size>0
      str = ""
      comments.each_with_index do |c,i|
        str += content_tag :div, "#{c.user_name}: #{c.content}</br>#{c.created_at}", :class => 'comment_div' 
      end
      str.html_safe
    else
      nil
    end
  end
  
  def show_user_head(user)
    if user.picture.present?
      if owner?
        link_to (image_tag user.picture.file.head.url), "#upload_head", "data-toggle" => 'modal', "rel" => "popover", "data-content" => '这里可以快速设置你的头像'  
      else
        image_tag user.picture.file.head.url
      end
    else
      link_to "", "#upload_head", "data-toggle" => 'modal', "rel" => "popover", "data-content" => '这里可以快速设置你的头像', "class" => "avatar_image"  
    end
  end
end
