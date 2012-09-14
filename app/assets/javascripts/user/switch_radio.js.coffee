$(document).ready(()->
  $("input[name='switch']").each(()->
    $(this).nextAll('form').hide('slow') if $(this).attr("checked") != 'checked'
    $(this).bind("click", ()->
      $(this).nextAll('form').show('slow')
      $("input[name='switch']").each(()->
        $(this).nextAll('form').hide('slow') if $(this).attr("checked") != "checked"
      )
    )
  )
)


