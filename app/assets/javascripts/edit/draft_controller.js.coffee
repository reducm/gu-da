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
    div.append("<table class='table table-striped', id='draft_table'><thead><tr><th>日期</th><th>题目</th></tr></thead></table>") unless $('#draft_table')[0]?
    table = $("#draft_table")
    table.find("tbody").remove()
    tbody = $("<tbody></tbody>")
    table.append(tbody)
    for draft, i in ds
      tbody.append("<tr><td>#{draft.date}</td><td>#{operate_title(draft.title)}</td></tr>")
      
operate_title = (title)->
  title = $.trim(title)
  if title? && title.length!=0
    return title
  else
    return '无题目'


