$(document).ready(->
  $('body').bind("dragover", ()->
    e.stopPropagation()
    e.preventDefault()
    false
  )

  $("#drag_test").draggable()
  $("#drop_file").droppable(
    {
      drop:(event,ui)->
        $(this).html(ui.draggable.html())
    }
  )
)
