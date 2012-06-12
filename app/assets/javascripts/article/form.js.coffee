$(document).ready(->
  $('#toggle_preview').bind('click',()->
    $("#article").toggleClass("edit_preview_width")
    $("#preview").toggle()
  )
)
