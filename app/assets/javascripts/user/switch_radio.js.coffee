$(document).ready(()->
  $("input[name='switch']").each(()->
    $(this).bind("switch_display",()->
      if $(this).attr("checked") == "checked"
      else
        $(this).next().show()
    )
  )

  $("input[name='switch']").each(()->
    $(this).next().hide() if $(this).attr("checked") != 'checked'
    $(this).bind("click", ()->

    )
  )
)


