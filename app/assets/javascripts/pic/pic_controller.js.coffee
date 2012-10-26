#给我一个drop的按钮,ul列表，要ajax_upload到的action，预览图的宽度, 生成一个可以传图的controller
class window.PicController
  constructor:(@button, @ul, @action, @picwidth="100px",fdata)->
    @button.css("display","block")
    @input = @button.browseElement()
    @imgs = []
    @formdata = new FormData()

    for key, value of fdata
      @formdata.append(key, value)

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
    $("img[data-toggle='pic']").each(()->
      new PicView($(this))
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

