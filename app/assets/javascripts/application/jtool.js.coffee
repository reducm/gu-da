$(document).ready(->
  window.original_location = window.location.pathname
)

window.set_location = (str) ->
  ol = window.original_location
  window.location = ol+str
