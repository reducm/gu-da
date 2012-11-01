#给我一个drop的按钮,ul列表，要ajax_upload到的action，预览图的宽度, 可选框框的drag_div, 和上传图片的限制生成一个可以传图的controller
class window.PicController
  constructor:(@button, @ul, @action, @picwidth="100px",fdata, @drag_div, @limit=4, @callback)->
    @button.css("display","block")
    @input = @button.browseElement()
    @imgs = []
    @formdata = new FormData()

    for key, value of fdata
      @formdata.append(key, value)

    that = this
    window.tempf = @formdata
    @input.on("change", $.proxy(this.fill_ul, this))
    @button.on("drop", $.proxy(this.fill_ul, this))
    @drag_div.on("drop", $.proxy(this.fill_ul, this)) if @drag_div

    $("img[data-toggle='pic']").each(()->
      new PicView($(this))
    )

  fill_ul: (event)->
    event.stopPropagation()
    event.preventDefault()
    `var target = (event.originalEvent.dataTransfer)  ? (event.originalEvent.dataTransfer) : (event.originalEvent.target)`
    files = target.files
    $.pnotify({text:"选择的图片超过4张,将上传最后4张", type:"error", title:"注意!" }) if files.length > 4
    this.create_upload_button(this.ul)
    this.imgs = this.makePicArr(files)


  makePicArr:(files,ul=@ul)->
    for file,i in files
      break if i == @limit
      fr = new FileReader()
      @formdata.append("pictures[#{i}]",file)
      fr.onload = (e)=>
        ul.prepend("<li><img src=\"#{e.target.result}\" width=\"#{@picwidth}\" /></li>")
      fr.readAsDataURL(file)

  create_upload_button:(ul) ->
    ul.empty()
    a = $("<a href=\"###\" class=\"btn btn-success\">上传</a>")
    ul.append(a)
    a.on("click",()=>
      p = new PicUploader(@action, @formdata,@callback)
      p.upload()
    )

