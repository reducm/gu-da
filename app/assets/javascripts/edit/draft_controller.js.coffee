$(document).ready(->
  article = $("#article")
  preview = $("#preview")
  content = $("#article_content")
  title = $("#article_title")
  draft_div = $('#draft')

  init_draft()

  content.bind('keyup',()->
    value = $(this).val()
    set_draft(title.val(), value)
  )

  draft_div.on('shown', ()->
    operate_draft()
  )
)

class DraftController
  constructor:(@title,@content,@draft_div)->
    init()
    @content.bind('keyup',()=>
      update(@title.val(), @this.val())
    )
    @draft_div.bind('shown',()=>
      show()
    )

  init:()->
    @timestamp ?= Date.now()

  update:(title,content)->
    Draft.update(@timestamp, title, content)
  show:()->


init_draft = ()->
  draft = store.get('draft')
  if (typeof draft == 'undefined' || draft == null)
    draft = {}
    store.set('draft',draft)
  window.draftstamp or= Date.now()
  draft[window.draftstamp] or= {}
  store.set('draft',draft)

set_draft = (title, content)->
  if content.length > 50 && content.length % 60 == 0
    draft = store.get('draft')
    draft[window.draftstamp]['title'] = title
    draft[window.draftstamp]['content'] = content
    store.set('draft', draft)


operate_draft = ()->
  draft = store.get('draft')
  div = $('#draft .modal-body')
  div.append("<table class='table table-striped', id='draft_table'><thead><tr><th>日期</th><th>题目</th></tr></thead></table>") unless $('#draft_table')[0]?
  table = $("#draft_table")
  table.find("tbody").remove()
  tbody = $("<tbody></tbody>")
  table.append(tbody)
  map_draft(draft, (k,v)->
    tbody.append(wrap_draft_tag(k,v))
  )

wrap_draft_tag = (timestamp, article_hash)->
  timestamp = Jtime::time_at(parseInt(timestamp))
  "<tr><td>#{timestamp}</td><td>#{operate_title(article_hash.title)}</td></tr>"

operate_title = (title)->
  title = $.trim(title)
  if title? && title.length!=0
    return title
  else
    return '无题目'

  #便利draft提供出来的draft, yield出的是由新到旧排好序的草稿
map_draft = (draft, fn)->
  array = []
  for k,v of draft
    array.push(parseInt(k))
  array = Jarray::sort(array,true)
  array.reverse()
  for i in array
    fn(i, draft[i])

