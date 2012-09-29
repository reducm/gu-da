$(document).ready(->
  $("body").on("dragover", (e)->
    e.stopPropagation()
    e.preventDefault()
    false
  )
  
  pc = new PicController($(".drop_file"))
)

class window.PicController
  constructor:(drop_button,picwidth="100px")->
    @button = drop_button
    @picwidth = picwidth
    @input = @button.find("input")
    @imgs = []
    that = this
    @input.on("change", ()->

    )
    @button.on("drop", (event)->
      event.stopPropagation()
      event.preventDefault()
      files = event.originalEvent.dataTransfer.files
      $(this).after("<ul class='show_upload_pic unstyled'></ul>")
      after=$(this).next()
      after.append("<a class=\"btn btn-success\">上传</a>")
      that.imgs = that.makePicArr(files,$(this).next())
    )

  makePicArr:(files,ul)->
    for file in files
      fr = new FileReader()
      fr.onload = (e)=>
        ul.prepend("<li><img src=\"#{e.target.result}\" width=\"#{@picwidth}\" /></li>")
      fr.readAsDataURL(file)




