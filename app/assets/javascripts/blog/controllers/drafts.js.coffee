#= require ../models/draft
#= require_tree ../views/drafts
$ = jQuery.sub()
Draft = Blog.Draft

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Draft.find(elementID)

class Show extends Spine.Controller
  constructor:()->
    super
    tr = @view('drafts/tr')(@model)
    @tr = $(tr)
    @restore_button = @tr.find("a[data-toggle='restore']")
    @delete_button = @tr.find("a[data-toggle='delete']")
    @tbody = @table.children("tbody")
    @tbody.prepend(@tr)
    @model.bind("update", @render)
    @model.bind("destroy", @remove)
    @delete_button.on("click", =>@model.destroy())
    @restore_button.on("click", =>@restore())
    @tr.on("mouseenter mouseleave", @toggle_button)

  render:(model)=>
    tr = @view('drafts/tr')(model)
    @tr.html($(tr).html())

  remove:()=>
    @tr.remove()

  restore: ()=>
    @content.val(@model.content)
    @title.val(@model.title)

  toggle_button: ()->
    $(this).find("td:last div").toggle()



class Blog.DraftsController extends Spine.Controller
  elements:
    '.modal-body': 'modal_body'
    '#automatic_draft': 'automatic_draft'
    '#manual_draft': 'manual_draft'
  events:
    "click a[data-toggle='save-draft']": "manual_create"
  
  constructor: ()->
    super
    @manual_draft.append(@view("drafts/table"))
    @automatic_draft.append(@view("drafts/table"))
    @save_button.bind("click", @manual_save)
    Draft.fetch()
    Draft.bind("refresh", ()=>Draft.each(@init_show))

#private
  init_show: (draft)=>
    options = {model:draft, converter:@converter, title:@title, content:@content, table:@automatic_draft.children("table")}
    options['table'] = @manual_draft.children("table") if draft.manual
    new Show(options)
  
  manual_save: ()=>
    if @manual_model
      @manual_model = Draft.find(@manual_model.id).updateAttributes({title:@title.val(),content:@content.val()})
    else
      d = new Draft({title:@title.val(),content:@content.val(),manual:true, created_at: (new Date())})
      if d.save()
        @init_show(d)
        @manual_model = d
