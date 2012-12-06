class Blog.Comment extends Spine.Model
  @configure 'Comment', 'content', 'created_at', 'updated_at', 'user_id', 'article_id', 'visitor_name', 'visitor_email, user_head'
  @extend Spine.Model.Ajax
  @url: "#{window.location}/comments"

  show_user_head: ()->
    if @user_head
      "<img src='#{@user_head}' width='80' />"
    else
      "<i class='avatar_image'></i>"


Blog.Comment.bind("refresh", ->
  Spine.trigger('fill.comments')
)
