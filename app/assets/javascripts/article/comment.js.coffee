$(document).ready(->
  comments = $("#comments")
  textarea = $("#comment_textarea")
  button = $("#comment_commit_button")
  $("#new_comment").live('ajax:success',(event,data)->
    console.log(data)
    comments.append(wrap_comment(data))
    textarea.val("")
  )

  textarea.bind('focus', ->
    button.show('fast')
    $("#visitor_name").show('fast')
    $("#visitor_email").show('fast')
    $(this).animate({height: '80px'},'fast')
  )

  textarea.bind('keyup', (e)->
    $("#new_comment").submit() if (e.ctrlKey && e.which == 13 || e.which == 10)
  )
)

wrap_comment = (comment)->
 """ 
    <div class=\"comment_each\" id="" floor=""> 
      <div class=\"head_div\">
        #{wrap_head(comment)}
      </div>

      <div class=\"comment_content\">
        <div>#{comment.user_name}</div><br/>
        #{comment.content}<br />
        <div class=\"time pull-right\">#{comment.created_at}</div>
      </div>

      <div class=\"empty_height\"></div>
      <div class=\"empty_height\"></div>
      <div class=\"empty_height\"></div>
    </div>
 """

wrap_head = (comment)->
  if comment.user_picture?
    "<a href=\"javascript:void(0)\"><img src=\"#{comment.user_picture}\" /></a>"
  else
    "<i class=\"avatar_image\"></i>"
