#给我一个drop的按钮,ul列表，要ajax_upload到的action，预览图的宽度, 生成一个可以传图的controller
class window.PicController
  constructor:(@button, @ul, @action, @picwidth="100px",fdata, @drag_div, @limit=4)->
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
    files = event.originalEvent.target.files
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
      p = new PicUploader(@action, @formdata,
        (data)->
          console.log(data)
      )
      p.upload()
    )

