class Blog.Draft extends Spine.Model
  @configure 'Draft', 'title', 'content', 'manual', 'created_at','updated_at'
  @extend Spine.Model.Ajax
  #@include Spine.Events
  #@url "/drafts"
  #
  validate:()->
    if @manual
      unless @title
        "草稿必须要有标题"
      else unless @content
        "草稿必须要有内容"


class Blog.AutoDraft extends Spine.Model
  @configure 'AutoDraft', 'title', 'content', 'manual', 'created_at','updated_at'
  @extend Spine.Model.Local
  constructor: ()->
    super
    @manual = false

Blog.Draft.bind("error", (event,message)->
  $.pnotify({title:'保存失败', text:message, type:'error'})
)

Blog.AutoDraft.bind("create", (model)->
  console.log(model)
  #$.pnotify({text:'自动保存草稿成功', type:'success'})
)
