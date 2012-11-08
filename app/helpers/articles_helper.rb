#encoding: utf-8
module ArticlesHelper
  def owner?
    @owner || @admin
  end

  def admin?
    @admin
  end

  def logo_link
    @logined ? name_path(@user_name) : root_path
  end

  def flash_message
    f = flash.to_hash
    if f.size > 0
      str = f.values.join(", ")
      c = f.has_key?(:error) ? "danger" : "success"
      content_tag :script, raw( "$(document).ready(function(){$.pnotify({text:\"#{str}\",type:\"#{c}\"})});")   
    end
  end

  def catagory_sidebar(user)
    render partial: 'layouts/catagory', locals: { catagories: @catagories, user_id: user.id}
  end

  def user_information_sidebar(user)
    render partial: 'articles/userinformation', locals: {user: user}
  end

  def catagory_get_name_link(c)
    link_to c.name, id_default?(c.id) ? "#{catagory_path(0)}?user_id=#{c.user_id}" : user_catagory_path(c.user_id, c)
  end

  def catagory_get_delete_link(c)
    id_default?(c.id) ? nil : (link_to "x", catagory_path(c), method:'delete', remote:true, class:'pull-right')
  end

  def catagory_name(article, catagories)
    article.catagory_id == 0 ? link_to("默认分类",user_catagory_path(article.user_id, 0)) : link_to(catagories.find{|c| c.id == article.catagory_id}.name, user_catagory_path(article.user_id,article.catagory_id))
  end

  def id_default?(id)
    id == nil || id ==0 
  end

  def article_width_height
    if new_or_edit?
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
        str += content_tag :div, "#{c.user_name}: #{c.content}</br>#{c.created_at}", class: 'comment_each' 
      end
      str.html_safe
    else
      nil
    end
  end

  def show_user_head(user = nil, width=nil, version=:head)
    if user.nil?
      return content_tag :i, "", class: 'avatar_image' 
    end

    if user.head.present?
      if owner?
        link_to (get_image_link(user,width,version)), "#upload_head", "data-toggle" => 'modal', "rel" => "popover", "data-content" => '这里可以快速设置你的头像'  
      else
        get_image_link(user,width,version)
      end
    else
      if owner?
        link_to "", "#upload_head", "data-toggle" => 'modal', "rel" => "popover", "data-content" => '这里可以快速设置你的头像', "class" => "avatar_image"  
      else
        content_tag :i, "",class: 'avatar_image' 
      end
    end
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar#{gravatar_id}.png?s=250"
  end

  def new_or_edit?
    params[:action].in? %w(edit new create update demonew demoshow)
    #    params[:action] == ('edit' || 'new' || 'create' || 'update')
  end

  def demo?
    params[:action].in? %w(demonew demoshow)
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

  def get_notifications_count(user_id)
    c = Notification.where("receiver_id=? and readed=0", user_id).count
    span = if c > 0
             content_tag :span, c, class: 'badge jbadge-info'
           else
             content_tag :span, c, class: 'badge '
           end
    link_to span, user_notifications_path(user_id)
  end

  def active_class(symbol)
    if symbol.to_s == params[:controller]
      'class=active'
    end
  end

  def sprite_tag(class_name)
    content_tag :i, '', class:class_name, style:'display:inline-block'
  end

  def get_authentication_status(client,authentication_hash)
    if authentication_hash.nil? || authentication_hash[client].nil?
      link_to "尚未关联", "/auth/#{client}"
    else
      if expires?(authentication_hash[client]['expires']) 
        link_to "已过期,重新授权", "/auth/#{client}"
      else
        content_tag(:span, '已关联 | ') + link_to('取消', user_authentication_path(@user_id, authentication_hash[client]['id']), method:'delete')
      end
    end
  end

  def expires?(timestamp)
    return false unless timestamp
    if timestamp.class == String
      timestamp = timestamp.to_i
    end
    Time.now.to_i - timestamp >= 0
  end

  def get_authentication_info(client,authentication_hash)
    if authentication_hash.nil? || authentication_hash[client].nil?
      link_to "尚未关联", "/auth/#{client}"
    else
      image_tag(authentication_hash[client]['image']) + content_tag(:span,authentication_hash[client]['nickname'], class:'luser_name')  
    end
  end

  private
  def t_to_i(regtime)
    (regtime).to_i
  end

  def get_image_link(user,width=nil,version)
    url = (version) == :origin ? user.head.file.url : user.head.file.send(version).url
    unless width.nil?
      image_tag url, width:"#{width}px"
    else
      image_tag url
    end
  end

  def share_article(article)
    callpartial = false 
    title_str = "分享文章"
    if cookies[:create_article]
      title_str = "文章创建成功,要分享吗?"
      callpartial = true
    end

    if cookies[:update_article]
      title_str = "文章修改成功,要分享吗?"
      callpartial = true
    end
    content = "发表了文章：#{article.title}, \"#{article.content.first(50)}...\" #{article_url(article)}"
    callpartial ? (render partial: 'share', locals: {authentications: Authentication.get_all(@user_id),title: title_str, content: content, article: article}) : nil
  end

  def share_to_image(provider)
    content_tag :i,"", class: "icons_#{provider}", style: "display:inline-block"
  end

  def pic_preview(picture)
    raw "<img class=\"img-polaroid\" data-toggle='pic' src=\"#{picture.file.small.url}\" id='img_#{picture.id}'/>"
  end

  def modal(options = {})
    options= {id:"",button:"确定",header:"", prompt:"", style:""}.merge(options)
    render(layout:"layouts/modal", locals:options) do
      yield
    end
  end
  
  def modal_link(href, str, sclass="btn")
    raw "<a href=\"#{href}\" role=\"button\" class=\"#{sclass}\" data-toggle=\"modal\">#{str}</a>"
  end
end
