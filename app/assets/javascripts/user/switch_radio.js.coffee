#用于在第三方认证返回的时候绑定已有用户或切换到新建用户上
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


