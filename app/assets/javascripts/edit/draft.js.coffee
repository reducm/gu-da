$(document).ready(->
  article = $("#article")
  preview = $("#preview")
  content = $("#article_content")
  title = $("#article_title")
  preview_content = $('#preview_content')
  preview_title = $('#preview_title')
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

init_draft = ()->
  draft = store.get('draft')
  if (typeof draft == 'undefined' || draft == null)
    store.set('draft',{})
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
  div.append("<table class='table table-striped', id='draft_table'><th><td>日期</td><td>题目</td></th></table>") unless $('#draft_table')[-1]?
  table = $("#draft_table")
  map_draft(draft, (k,v)->
    table.append(wrap_draft_tag(k,v))
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

map_draft = (draft, fn)->
  for k,v of draft
    fn(k,v)



