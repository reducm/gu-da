$(document).ready(()->
  if $('.error').size() > 0
    $('.error input').each(->
      $(this).bind('focus', ->
        $(this).parents('.error').removeClass('error')
        $(this).next('span').remove()
      )
    )

  $("#user_description").count_num(140) #description会有字数限制的提示
)


