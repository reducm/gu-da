$(document).ready(->
  article = $("#article")
  preview = $("#preview")
  content = $("#article_content")
  title = $("#article_title")
  preview_content = $('#preview_content')
  preview_title = $('#preview_title')
  window.preview_style = "html"

  converter = new Showdown.converter()

  preview.height(article.height())
  $('#toggle_preview').bind('click',()->
    article.toggleClass("edit_preview_width")
    preview.toggle()
    fill_preview(content.val())
    fill_preview_title(title.val())
  )

  title.bind("keyup", ()->
    str = $(this).val()
    fill_preview_title(str)
  )

  content.bind("keyup", ()->
    str = $(this).val()
    fill_preview(str)
  )

  $("#preview_toolbar ul li a").bind("click", ()->
    text = $(this).text()
    $("#preview_toolbar .dropdown-toggle").html("#{text}<span class=\"caret\"></span>")
    window.preview_style = $(this).attr("data-toggle")
    fill_preview(content.val())
  )

  fill_preview = (str)->
    mstr = converter.makeHtml(str)
    switch window.preview_style
      when "html"
        preview_content.html(mstr)
      when "text"
        preview_content.text(mstr)
      else
        nil

  fill_preview_title = (str) ->
    preview_title.html("<h1 class=\"title_h\">#{str}</h1>")
)




