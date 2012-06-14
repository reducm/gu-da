$(document).ready(->
  comments = $("#comments")
  textarea = $("#comment_textarea")
  button = $("#comment_commit_button")
  form = $("#new_comment")

  form.submit(()->
    button.button('loading')
  )
  
  form.live('ajax:success',(event,data)->
    console.log(data)
    if str = Jajax::callback(data, wrap_comment)
      comments.append(str)
      textarea.val("")
      set_location ("#comment_#{data.id}")
    else
      textarea.focus()
    button.button('reset')
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
    <div class=\"comment_each\" id="comment_#{comment.id}" floor=""> 
      <div class=\"head_div\">
        #{wrap_head(comment)}
      </div>

      <div class=\"comment_content\">
        <div>#{comment.user_name}</div><br/>
        #{comment.content}<br />
        <div class=\"time pull-right\">#{comment.strtime}</div>
      </div>

      <div class=\"empty_height\"></div>
      <div class=\"empty_height\"></div>
      <div class=\"empty_height\"></div>
    </div>
 """

wrap_head = (comment)->
  if comment.user_picture?
    "<a href=\"javascript:void(0)\"><img src=\"#{comment.user_picture}\" width='80px' /></a>"
  else
    "<i class=\"avatar_image\"></i>"
