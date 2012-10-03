$(document).ready(->
  $("body").on("dragover", (e)->
    e.stopPropagation()
    e.preventDefault()
    false
  )
  ul = $("#ul_for_pic")
  pc = new PicController($(".drop_file"),ul,"/pages")
)

class window.PicController
  constructor:(drop_button, @ul, @action, @picwidth="100px")->
    @button = drop_button
    @input = @button.find("input")
    @imgs = []
    @formdata = new FormData()
    @formdata.append("title","index_images")
    that = this
    window.tempf = @formdata
    @input.on("change", (event)->
      #console.log(event)
      event.stopPropagation()
      event.preventDefault()
      files = event.originalEvent.target.files
      that.create_upload_button(that.ul)
      that.imgs = that.makePicArr(files)
    )
    @button.on("drop", (event)->
      #console.log(event)
      event.stopPropagation()
      event.preventDefault()
      files = event.originalEvent.dataTransfer.files
      that.create_upload_button(that.ul)
      that.imgs = that.makePicArr(files)
    )

  makePicArr:(files,ul=@ul)->
    for file,i in files
      fr = new FileReader()
      @formdata.append("pictures[#{i}]",file)
      fr.onload = (e)=>
        ul.prepend("<li><img src=\"#{e.target.result}\" width=\"#{@picwidth}\" /></li>")
      fr.readAsDataURL(file)

  create_upload_button:(ul) ->
    a = $("<a href=\"###\" class=\"btn btn-success\">上传</a>")
    ul.append(a)
    a.on("click",()=>
      p = new PicUploader(@action, @formdata,
        (data)->
          console.log(data)
      )
      p.upload()
    )






