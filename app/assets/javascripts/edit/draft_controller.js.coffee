$(document).ready(->
  article = $("#article")
  preview = $("#preview")
  content = $("#article_content")
  title = $("#article_title")
  draft_div = $('#draft')

  dc = new DraftController(title,content,draft_div)
)

class DraftController
  constructor:(@title,@content,@draft_div)->
    this.init()
    @content.bind('keyup',()=>
      this.update(@title.val(), @content.val())
    )
    @draft_div.bind('shown',()=>
      this.show()
    )
    $("a[data-toggle='save-draft']").bind('click',()=>
      draft = new Draft(@timestamp, @title.val(), @content.val(),true)
      draft.save()
      @draft_div.modal('show')
    )

  init:()->
    @timestamp ?= Date.now()
    draft = store.get('draft')
    if (typeof draft == 'undefined' || draft == null)
        draft = {}
        store.set('draft',draft)

  update:(title,content)->
    Draft::update(@timestamp, title, content)

  show:()->
    ds = Draft::all()
    div = @draft_div.find('.modal-body')
    atbody = $("<tbody></tbody>")
    mtbody = $("<tbody></tbody>")
    for draft, i in ds
      if draft.manual
        tr = $("<tr><td>#{draft.date}</td><td>#{operate_title(draft.title)}</td><td></td></tr>")
        tr.popover({title:operate_title(draft.title),content:draft.content})
        mtbody.append(tr)
      else
        tr = $("<tr><td>#{draft.date}</td><td>#{operate_title(draft.title)}</td><td></td></tr>")
        tr.popover({title:operate_title(draft.title),content:draft.content})
        atbody.append(tr)
    build_table($("#automatic_draft"),atbody)
    build_table($("#manual_draft"),mtbody)

operate_title = (title)->
  title = $.trim(title)
  if title? && title.length!=0
    return title
  else
    return '无题目'

build_table = (element, tbody)->
  element.find("table").remove()
  element.append("<table class='table table-striped'><thead><tr><th>日期</th><th>题目</th><th>操作</th></tr></thead></table>")
  element.find("table").append(tbody)



