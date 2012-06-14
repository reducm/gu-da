$(document).ready(()->
  if $('.error').size() > 0
    $('.error input').each(->
      $(this).bind('focus', ->
        $(this).parents('.error').removeClass('error')
        $(this).next('span').remove()
      )
    )

  $('#edit_user_left').find('a').click((e)->
    e.preventDefault()
    $(this).tab('show')
  )

  $("#user_description").count_num(140) #description会有字数限制的提示
  
  pill_click()
)

pill_click= ()->
  y = window.location.toString().match(/(#.+)$/)
  if y?
    $("a[href='#{y[0]}']").click()

