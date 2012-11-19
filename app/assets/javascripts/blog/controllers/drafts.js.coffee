#= require ../models/draft
#= require_tree ../views/drafts
$ = jQuery.sub()
Draft = Blog.Draft
AutoDraft = Blog.AutoDraft

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
    @delete_button.on("click", (event)=>
      @model.destroy()
      event.stopPropagation()
      event.preventDefault()
    )
    @restore_button.on("click", @restore)
    @tr.on("mouseenter mouseleave", @toggle_button)
    @tr.on("click", @model, @toggle_content)

  render:(model)=>
    console.log "fuck"
    tr = @view('drafts/tr')(model)
    @tr.html($(tr).html())

  remove:()=>
    @tr.remove()

  restore: (event)=>
    @content.val(@model.content)
    @title.val(@model.title)
    event.stopPropagation()
    event.preventDefault()

  toggle_button: ()->
    $(this).find("td:last div").toggle()
    $(this).toggleClass("success")

  toggle_content: (e)->
    model = e.data
    tr = $(this)
    id = tr.attr("data-id")
    content_tr = $("#draft_#{id}")
    content_tr.toggle('fast')



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
    AutoDraft.fetch()
    Draft.bind("refresh", ()=>AutoDraft.each(@init_show))
    @content.on("keyup", @automatic_save)

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

  automatic_save: ()=>
    # should add 60words save and settimeout save
    if @automatic_model
      @automatic_model.updateAttributes(title:@title.val(), content:@content.val())
    else
      @automatic_model = new AutoDraft({title:@title.val(),content:@content.val(),manual:false, created_at: (new Date())})
      if @automatic_model.save()
        @init_show(@automatic_model)

