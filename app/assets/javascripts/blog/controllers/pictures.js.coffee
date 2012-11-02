#$ = jQuery.sub()
Picture = Blog.Picture

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Picture.find(elementID)

class Blog.PicturesUpload extends Spine.Controller
  elements:
    ".drop_file": "button"
    "#ul_for_pic": "ul_upload"
    ".drag_to": "drag_div"

  #events:

  constructor: ->
    super
    @url or= "/pictures"
    @el = $("#upload_pic_modal")
    @limit or= 4
    @pictureable_type or="User"
    @pictureable_id or= window.guda.user_id
    @models or= []
    @input = @button.browseElement()
    window.haha = this
    #@input.on("change", @fill_ul))

#event callback
  fill_ul: (event)=>
    event.stopPropagation()
    event.preventDefault()
    `var target = (event.originalEvent.dataTransfer)  ? (event.originalEvent.dataTransfer) : (event.originalEvent.target)`
    files = target.files
    $.pnotify({text:"选择的图片超过4张,将上传最后4张", type:"error", title:"注意!" }) if files.length > 4
    @uload_button = @create_upload_button(@ul_upload)
    @upload_button.on("click", @upload)
    @show_pic(files)

  #upload: (event)=>


#private method
  create_upload_button: (ul)->
    ul.empty()
    a = $("<a href=\"###\" class=\"btn btn-success\">上传</a>")
    ul.append(a)
    a
  
  @show_pic: (files)->
    for file,i in files
      break if i == @limit
      fr = new FileReader()
      @prepare_models(file)
      fr.onload = (e)=>
        @ul.prepend("<li><img src=\"#{e.target.result}\" width=\"#{@picwidth}\" /></li>")
      fr.readAsDataURL(file)

  @prepare_models: (file)->
    p = new Picture({pictureable_type:@pictureable_type, pictureable_id:@pictureable_id, file: file})
    @models.push(p)


class PicturesLoad extends Spine.Controller



class Blog.PicturesController extends Spine.Controller



