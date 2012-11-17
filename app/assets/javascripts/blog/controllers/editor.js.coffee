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
    $("body").bind("keydown.m", @markdown_modal)
    $(window).on("resize",@init_article_preview_height)
    $('textarea').editor()
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

  toggle_preview: ()->
    @article.toggleClass("edit_preview_width")
    @preview.toggle()
    @fill_preview_content()
    @fill_preview_title()
    #fix_pcontent_height()
    $("#temp_textarea").remove() if $("#temp_textarea")[0]?



  fill_preview_content: ()=>
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
        ta.val(raw)
      else
        null

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





