$(document).ready(->
  comments = $("#comments")
  $("#new_comment").live('ajax:success',(event,data)->
    console.log(data)
    comments.append("<div class='comment_each'>#{data.user_name}: #{data.content}, created_at: #{data.created_at}</div>")
  )
)
