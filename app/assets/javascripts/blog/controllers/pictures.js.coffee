#$ = jQuery.sub()
Picture = Blog.Picture

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Picture.find(elementID)

class Blog.PicturesUpload extends Spine.Controller
  #events:
  @include Blog.ajax_formdata

  elements:
    ".drop_file": "button"
    ".drag_to": "drag_div"
    "#ul_for_pic": "ul_upload"

  constructor: ->
    super
    @url or= "/pictures"
    @limit or= 4
    @picwidth or= "100px"
    @pictureable_type or="User"
    @pictureable_id or= window.guda.user_id
    @models or= []
    @input = @button.browseElement()
    @input.on("change", @fill_ul)
    @button.on("drop", @fill_ul)
    @drag_div.on("drop", @fill_fl)
    $("body").on("dragover", @clean_propagation)

#event callback
  fill_ul: (event)=>
    event.stopPropagation()
    event.preventDefault()
    `var target = (event.originalEvent.dataTransfer)  ? (event.originalEvent.dataTransfer) : (event.originalEvent.target)`
    files = target.files
    $.pnotify({text:"选择的图片超过4张,将上传最后4张", type:"error", title:"注意!" }) if files.length > 4
    @upload_button = @create_upload_button(@ul_upload)
    @upload_button.on("click", @upload)
    @show_pic(files)

  upload: (event)=>
    formdata = new FormData()
    formdata.append("pictureable_type",@pictureable_type)
    formdata.append("pictureable_id",@pictureable_id)
    formdata.append("pictures[#{i}]", model.file)for model,i in @models
    @upload_button.loading()
    @ajax_formdata(@url,formdata,@upload_success)

#private method
  create_upload_button: (ul)->
    ul.empty()
    a = $("<a href=\"###\" class=\"btn btn-success\">上传</a>")
    ul.append(a)
    a

  show_pic: (files)=>
    for file,i in files
      break if i == @limit
      fr = new FileReader()
      @prepare_models(file)
      fr.onload = (e)=>
        @ul_upload.prepend("<li><img src=\"#{e.target.result}\" width=\"#{@picwidth}\" /></li>")
      fr.readAsDataURL(file)

  prepare_models: (file)->
    p = new Picture({pictureable_type:@pictureable_type, pictureable_id:@pictureable_id, file: file})
    @models.push(p)

  clean_propagation:(event)->
    event.stopPropagation()
    event.preventDefault()
    false

  upload_success:(data)=>
    $.pnotify(text:"上传成功", type:"success")
    @upload_button.unloading()
    @ul_upload.empty()
    @el.modal("hide")
    @PicturesLoad.preload(data)

class Blog.PicturesLoad extends Spine.Controller
  #elements:
  @include Blog.ajax_formdata
  events:
    "click .append_pic":"append_pic"
    "mouseenter .pic_item":"show_wrapper"
    "mouseleave .pic_item":"clean_wrapper"
    "ajax:loading .remove_pic":"ajax_loading"
    "ajax:success .remove_pic":"destroy"

  constructor:()->
    super
    @models or= []
    @page or= 1
    @url = "/users/#{guda.user_id}/pictures"
    @button = @el.children(".btn")
    @append_ajax()


#private
  append_pic:(e)->
    id = $(e.target).parent().attr("pid")
    model = Picture.find(id)
    console.log(model)
    pos = @article_content.getCurPos()
    content = @article_content.val()
    left = content.slice(0, pos)
    right = content.slice(pos)
    url = model.file.normal.url || model.file.url
    left = left+"![](#{url})"
    newPos = left.length
    @article_content.val(left+right)
    @article_content.setCurPos(newPos)

  destroy:(event, data)=>
    that = @
    Jajax::callback(data, (data)->
      $.pnotify(text:data.message, type:'success')
      id = data.id
      Picture.find(id).destroy()
      that.el.children("li[pid='#{id}']").remove()
    )
  
  show_wrapper:(e)->
    e.stopPropagation()
    e.preventDefault()
    return false if e.target.tagName.toLowerCase() != 'img'
    img = $(e.target)
    li = img.parent()
    model = Picture.find(li.attr("pid"))
    li.append @view("pictures/pic_wrapper")({model:model}) unless li.children(".remove_pic")[0]

  clean_wrapper:(e)->
    e.stopPropagation()
    e.preventDefault()
    return false if e.target.tagName.toLowerCase() != 'img'
    img = $(e.target)
    li = img.parent()
    model = Picture.find(li.attr("pid"))
    li.children("a").remove()

  append_ajax:()=>
    @el.loading()
    $.get(@url, {page:@page}, @append_data, "json")

  append_data:(data)=>
    $.pnotify(type:'info', text:"读取 #{data.pictures.length} 张新图片")
    @el.unloading()
    temp_models = @deal_data(data)
    that = @
    if @footer
      @footer.before @view("pictures/item")({models:temp_models})
    else
      @append @view("pictures/item")({models:temp_models})
      @el.append("<div class='footer'></div>")
      @footer = @el.children(".footer")
      @footer.waypoint((event, direction)->
        console.log direction
        that.append_ajax() if direction == 'down'
      ,
      offset: 'bottom-in-view'
      context: "#ul_showpic"
      )


  preload:(data)=>
    if data?
     return @prepend_data(data)
    return @append_ajax()

  prepend_data:(data)=>
    temp_models = @deal_data(data)
    @button.after @view("pictures/item")({models:temp_models})

  deal_data:(data)=>
    @page = parseInt(data.page) + 1
    temp = []
    for picture in data.pictures
      p = new Picture(picture)
      p.save()
      @models.push(p)
      temp.push(p)
    temp

class Blog.PicturesController extends Spine.Controller
  @extend Spine.Events
  elements:
    "#toggle_pic": "toggle_pic_button" #button
    "#form_toolbox": "form_toolbox"
    "#content_wrapper": "content_wrapper"
    "#ul_showpic": "ul_showpic"
    "#upload_pic_modal": "upload_modal"
    "#article_content": "article_content"

  constructor: ->
    super
    @el or= $("#container")
    @form_toolbox.find("a").each(-> $(this).tooltip({ delay:100, placement:'bottom'}))
    @toggle_pic_button.on("click", @toggle_pic)
    @toggle_upload_button = @ul_showpic.children(".btn")
    @upload_modal.on("shown", @init_upload)
    @PicturesLoad = new Blog.PicturesLoad({el: @ul_showpic.selector, article_content: @article_content})
    @ul_showpic.on('scroll',(event)->
      event.stopPropagation()
      event.preventDefault()
    )

#private
  init_upload:()=>
    el = "#upload_pic_modal"
    that = @
    @PictureUpload = new Blog.PicturesUpload({el:el, PicturesController:that, PicturesLoad:@PicturesLoad})

  toggle_pic:()=>
    @content_wrapper.toggleClass('content_showpic_width')
    @ul_showpic.toggle()
