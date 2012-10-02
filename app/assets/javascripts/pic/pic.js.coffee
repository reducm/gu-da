$(document).ready(->
  $("body").on("dragover", (e)->
    e.stopPropagation()
    e.preventDefault()
    false
  )
  ul = $("#ul_for_pic")
  pc = new PicController($(".drop_file"),ul)
)

class window.PicController
  constructor:(drop_button, ul, picwidth="100px")->
    @button = drop_button
    @picwidth = picwidth
    @ul = ul
    @input = @button.find("input")
    @imgs = []
    that = this
    @input.on("change", (event)->
      #console.log(event)
      event.stopPropagation()
      event.preventDefault()
      files = event.originalEvent.target.files
      that.ul.append("<a class=\"btn btn-success\">上传</a>")
      that.imgs = that.makePicArr(files)
    )
    @button.on("drop", (event)->
      #console.log(event)
      event.stopPropagation()
      event.preventDefault()
      files = event.originalEvent.dataTransfer.files
      that.ul.append("<a class=\"btn btn-success\">上传</a>")
      that.imgs = that.makePicArr(files)
    )

  makePicArr:(files,ul=@ul)->
    for file in files
      fr = new FileReader()
      fr.onload = (e)=>
        ul.prepend("<li><img src=\"#{e.target.result}\" width=\"#{@picwidth}\" /></li>")
      fr.readAsDataURL(file)




