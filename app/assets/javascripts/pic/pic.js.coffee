$(document).ready(->
  $("body").on("dragover", (e)->
    e.stopPropagation()
    e.preventDefault()
    false
  )
)
