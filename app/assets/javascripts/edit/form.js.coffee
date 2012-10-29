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
    fix_pcontent_height()
    $("#temp_textarea").remove()
  )

  title.on("keyup", ()->
    str = $(this).val()
    fill_preview_title(str)
    fix_pcontent_height()
  )

  content.on("scroll", ()->
    preview_content.scrollTop($(this).scrollTop()+33)
    $("#temp_textarea").scrollTop($(this).scrollTop()+33)
    console.log("as:",$(this).scrollTop(), "   ps:", preview_content.scrollTop())
  )

  content.bind("keyup", ()->
    str = $(this).val()
    fill_preview(str)
    preview_content.scrollTop($(this).scrollTop())
    if $("#temp_textarea")[0]?
      $("#temp_textarea").scrollTop($(this).scrollTop()+33)
    fix_pcontent_height()
  )

  $("#preview_toolbar ul li a").bind("click", ()->
    text = $(this).text()
    $("#preview_toolbar .dropdown-toggle").html("#{text}<span class=\"caret\"></span>")
    window.preview_style = $(this).attr("data-toggle")
    fill_preview(content.val())
  )

  $(window).bind("resize", ->
    preview.height(article.height())
  )

  fill_preview = (str)->
    mstr = converter.makeHtml(str)
    switch window.preview_style
      when "html"
        preview_content.html(mstr)
      when "text"
        raw = style_html(mstr)
        ta = $("<textarea readonly=\"readonly\" id=\"temp_textarea\"></textarea>")
        preview_content.html("")
        preview_content.append(ta)
        ta.height(content.height()+33)
        ta.val(raw)
      else
        null

  fill_preview_title = (str) ->
    `var str1 = str ? str : "题目"`
    preview_title.html("<h1>#{str1}</h1>")

  fix_pcontent_height = ()->
    preview_content.height(preview.height()-preview_title.outerHeight()-100)
)



