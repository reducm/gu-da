#encoding: utf-8
module ArticlesHelper
  def owner?
    @owner
  end

  def catagory_sidebar(user)
    render :partial => 'layouts/catagory', :locals => { :catagories => @catagories, :user_id => user.id}
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

  def catagory_get_name_link(c)
    link_to c.name, id_default?(c.id) ? "#{catagory_path(0)}?user_id=#{c.user_id}" : catagory_path(c)
  end

  def catagory_get_delete_link(c)
    id_default?(c.id) ? nil : (link_to "x", catagory_path(c), method:'delete', remote:true, class:'pull-right')
  end

  def id_default?(id)
    id == nil || id ==0 
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
        str += content_tag :div, "#{c.user_name}: #{c.content}</br>#{c.created_at}", :class => 'comment_each' 
      end
      str.html_safe
    else
      nil
    end
  end

  def show_user_head(user = nil, width=nil)
    if user.nil?
      return content_tag :i, "",:class => 'avatar_image' 
    end

    if user.picture.present?
      if owner?
        link_to (get_image_link(user,width)), "#upload_head", "data-toggle" => 'modal', "rel" => "popover", "data-content" => '这里可以快速设置你的头像'  
      else
        get_image_link(user,width)
      end
    else
      if owner?
        link_to "", "#upload_head", "data-toggle" => 'modal', "rel" => "popover", "data-content" => '这里可以快速设置你的头像', "class" => "avatar_image"  
      else
        content_tag :i, "",:class => 'avatar_image' 
      end
    end
  end

  def new_or_edit?
    params[:action] == 'edit' || params[:action] == 'new'
  end

  def jtime(time)
    normal = time.strftime('%Y年%m月%d日')
    regtime = (Time.now-time)
    if regtime < 60
      "刚刚"
    elsif regtime < 3600
      "#{(regtime/60).to_i}分钟前"
    elsif regtime < 86400
      "#{(regtime/3600).to_i}小时前"
    elsif regtime < 2592000
      "#{(regtime/86400).to_i}天前"
    elsif regtime < 31536000
      "#{(regtime/2592000).to_i}个月前"
    else 
      normal
    end
  end

  private
  def t_to_i(regtime)
    (regtime).to_i
  end

  def get_image_link(user,width=nil)
    unless width.nil?
      image_tag user.picture.file.head.url, :width=>"#{width}px"
    else
      image_tag user.picture.file.head.url
    end
  end
end
