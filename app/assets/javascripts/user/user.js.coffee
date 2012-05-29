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
)

