class Blog.Comment extends Spine.Model
  @configure 'Comment', 'content', 'created_at', 'updated_at', 'user_id', 'article_id', 'visitor_name', 'visitor_email', 'user_head', 'user_picture', 'user', 'user_name'
  @extend Spine.Model.Ajax
  @url: "#{window.location}/comments"

  show_user_head: ()->
    if @user_head
      "<img src='#{@user_head}' width='80' />"
    else
      "<i class='avatar_image'></i>"

  validate:()->
    unless @content
      "内容不能为空"
    if @user_id == 0
      unless @visitor_email
        "邮箱内容不能为空"
      else unless @visitor_name
        "访客名称不能为空"

  @create_from_ajax: (hash,callback)->
   $.post(@url,hash, (data)->
     Jajax::callback(data, (data)->
        console.log data
        c = new Comment(data)
        callback(c)
     )
   )



