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

Blog.Draft.bind("error", (event,message)->
  $.pnotify({title:'保存失败', text:message, type:'error'})
)
