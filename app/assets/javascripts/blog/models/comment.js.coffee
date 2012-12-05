class Blog.Comment extends Spine.Model
  @configure 'Comment', 'content', 'created_at', 'updated_at', 'user_id', 'article_id', 'visitor_name', 'visitor_email'
  @extend Spine.Model.Ajax
  @url: "#{window.location}/comments"

Blog.Comment.bind("ajaxSuccess", (status, xhr)->
)
