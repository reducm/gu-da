$(document).ready(->
  article = $("#article")
  preview = $("#preview")
  content = $("#article_content")
  title = $("#article_title")
  preview_content = $('#preview_content')
  preview_title = $('#preview_title')
  draft_div = $('#draft')

  draft = store.get('draft')

  if (typeof draft == 'undefined' || draft == null)
    store.set('draft',{})

  content.bind('keyup',()->
    value = $(this).val()
    if value.length > 50 && value.length % 60 == 0
      set_draft(title.val(), value)
  )

  set_draft = (title, content)->
    window.draftstamp or= Date.now()
    draft = store.get('draft')
    draft[window.draftstamp]['title'] = title
    draft[window.draftstamp]['content'] = content
    store.set('draft', draft)
  
  draft_div.on('shown', ()->
    draft = store.get('draft')
    div = $('#draft .modal-body')
    for k,v of draft
      div.append("#{k} : #{v}")
  )
)



