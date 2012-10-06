$(document).ready(->
  $("body").on("dragover", (e)->
    e.stopPropagation()
    e.preventDefault()
    false
  )
  ul = $("#ul_for_pic")
  pc = new PicController($(".drop_file"),ul,"/pages")
)

