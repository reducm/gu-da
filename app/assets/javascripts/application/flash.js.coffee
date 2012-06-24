$(document).ready(()->
  a = $("a[data-dismiss='close']")
  a.bind('click', ()->
    $('#flash').remove()
  )
)
