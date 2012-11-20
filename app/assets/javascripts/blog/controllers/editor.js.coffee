#= require ./drafts
$ = jQuery.sub()

class Blog.EditorController extends Spine.Controller
  elements:
    '#article': 'article'
    '#preview': 'preview'
    '#article_content': 'content'
    '#article_title': 'title'
    '#preview_content': 'preview_content'
    '#preview_title': 'preview_title'
    '#ul_showpic': 'ul_showpic'
    '#markdown_hint': 'markdown_hint'

  events:
    'click #toggle_preview': 'toggle_preview'
    'keyup #article_title': 'fill_preview_title'
    'keyup #article_content': 'fill_preview_content'
    'click #preview_toolbar ul li a': 'switch_preview_status'

  constructor: ->
    super
    @content_wrapper = @content.parent()
    @preview_style = 'html'
    @converter = new Showdown.converter()
    @init_markdown_hint()
    @init_article_preview_height()
    @draft_controller = new Blog.DraftsController({el:'#draft', content:@content, title:@title, converter:@converter, save_button:$("a[data-toggle='save-draft']")})
    $("body").bind("keydown.m", @markdown_modal)
    $(window).on("resize",@init_article_preview_height)
    $('textarea').editor()
    @content.dontScrollParent()
    @content.on("scroll", @fix_scroll)
#private
  init_article_preview_height: ()=>
    @article.height($("body").height() - $("#navbar").height() - 40)
    @preview.height(@article.height())

  init_markdown_hint:()->
    converter = @converter
    @markdown_hint.find("tbody>tr").each(()->
      target = $(this).children("td:last")
      origin = target.prev()
      origin = origin.children() if origin.children('pre')[0]?
      unless target.html()? && target.html().length > 0
        target.html(converter.makeHtml(origin.text()))
    )

  markdown_modal: ()=>
    @markdown_hint.modal(
      backdrop:true
      keyboard:true
      show:true
    )

  toggle_preview: ()=>
    @article.toggleClass("edit_preview_width")
    @preview.toggle()
    @fill_preview_content("html")
    @fill_preview_title()
    @fix_scroll()

  
  fill_preview_content: (preview_style)=>
    return false if $("#preview").is(":hidden")
    preview_style = preview_style.data if _.isObject(preview_style)
    @preview_style = preview_style if preview_style
    str = @content.val()
    mstr = @converter.makeHtml(str)
    switch @preview_style
      when "html"
        @preview_content.html(mstr)
      when "text"
        raw = style_html(mstr)
        ta = $("<textarea readonly=\"readonly\" id=\"temp_textarea\"></textarea>")
        @preview_content.html("")
        @preview_content.append(ta)
        ta.height(@content.height())
        ta.val(raw)
      else
        null
    @fix_scroll()

  fill_preview_title: () =>
    str = @title.val()
    `var str1 = str ? str : "题目"`
    @preview_title.html("<h1>#{str1}</h1>")

  switch_preview_status: (e)=>
    button = $(e.target)
    text = button.text()
    $("#preview_toolbar .dropdown-toggle").html("#{text}<span class=\"caret\"></span>")
    @preview_style = button.attr("data-toggle")
    @fill_preview_content()

  fix_scroll:()=>
    return false if $("#preview").is(":hidden")
    neo = @content
    if $("#temp_textarea")[0]
      matrix = $("#temp_textarea")
    else
      matrix = $("#preview")
    @calculate_scroll(neo, matrix)

  calculate_scroll:(neo, matrix)->
    if matrix[0].scrollHeight > neo[0].scrollHeight
      r = matrix[0].scrollHeight / neo[0].scrollHeight
      matrix.scrollTop(neo.scrollTop() * r)
    else
      matrix.scrollTop(neo.scrollTop())
    console.log "neo:", neo.scrollTop(), " matrix:", matrix.scrollTop()
    console.log neo[0].scrollHeight, "|", matrix[0].scrollHeight


  fix_pcontent_height: ()=>
      if @preview_style == 'html'
      else
        pos = @content.getCurPos()
        @preview_content.setCurPos(pos)

