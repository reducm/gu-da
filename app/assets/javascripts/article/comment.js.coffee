$(document).ready(->
  comments = $("#comments")
  textarea = $("#comment_textarea")
  button = $("#comment_commit_button")
  $("#new_comment").live('ajax:success',(event,data)->
    console.log(data)
    comments.append("<div class='comment_each'>#{data.user_name || data.visitor_name}: #{data.content}, created_at: #{data.created_at}</div>")
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
