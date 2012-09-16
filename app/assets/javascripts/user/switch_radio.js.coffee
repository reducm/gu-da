$(document).ready(()->
  $("input[name='switch']").each(()->
    $(this).nextAll('form').hide('fast') if $(this).attr("checked") != 'checked'
    $(this).bind("click", ()->
      $(this).nextAll('form').show('fast')
      $("input[name='switch']").each(()->
        $(this).nextAll('form').hide('fast') if $(this).attr("checked") != "checked"
      )
    )
  )
)


