#= require ./drafts
#$ = jQuery.sub()

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
    'click #link_button': 'add_link'
    'click #strong_button': 'add_strong'
    'click #italic_button': 'add_italic'

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
    @content.on("scroll", @fix_img_scroll)
    #@preview_content.on("contentchange", ()->console.log "in trigger---", $(this)[0].scrollHeight)
    $.pnotify(type:'error', text:'注意!Demo用户不能使用图片上传和手动保存草稿功能',hide:false) if guda.user_id == 0
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
    marked_str = @get_marked(str,@content.getCurPos())
    mstr = @converter.makeHtml(marked_str)
    switch @preview_style
      when "html"
        target = "#marked_jojo"
        mstr = mstr.replace("[[jojo]]", "<span id='marked_jojo'></span>")
        @preview_content.html(mstr)
        $("#preview_content img").imagesLoaded(()=>
          $.smoothScroll({ scrollElement:@preview, scrollTarget:target, speed:0 })
        )
      when "text"
        mstr = mstr.replace("[[jojo]]", "$$")
        raw = style_html(mstr)
        ta = $("<textarea readonly=\"readonly\" id=\"temp_textarea\"></textarea>")
        @preview_content.html("")
        @preview_content.append(ta)
        ta.height(@content.height())
        ta.val(raw)
      else
  
  get_marked:(str,pos)->
    left = str.slice(0,pos)
    right = str.slice(pos,str.length)
    marked = "[[jojo]]" #在内容里加上[[jojo]], 然后后面把他编译成<span id='marked_jojo'></span>
    mstr = left+marked+right
    #若然是连接或图片的话不用加mark
    if (/\[.*?\]\(.*?\[\[jojo\]\].*?\)/).test(mstr) or (/\[.*?\[\[jojo\]\].*?\]\(.*?/).test(mstr) #or (/\[.*?\[\[jojo\]\].*?\]/)
      return str
    mstr

  add_content_to_pos:(content,setPos=0)=>
    pos = @content.getCurPos()
    str = @content.val()
    left = str.slice(0,pos)
    right = str.slice(pos,str.length)
    new_str = left+content+right
    @content.val(new_str)
    if setPos == 0
      @content.setCurPos((left+content).length)
    else
      @content.setCurPos(left.length+setPos)
    
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

  fix_img_scroll:()=>
    imgs = @preview_content.find("img")
    pc = @preview_content
    if imgs.length > 0
      imgs_height = 0
      imgs.each(()->
        tm = new Image()
        tm.src = this.src
        tow = tm.width
        toh = tm.height
        limit_width =  pc.width()*0.5
        if tow > limit_width
          r = tow / limit_width
          rh = toh / r
        else
          rh = toh
        imgs_height += rh
      )
    @fix_scroll(Math.round(imgs_height))

  fix_scroll:(imgs_height = 0)=>
    return false if $("#preview").is(":hidden")
    imgs_height = 0 unless $.isNumeric(imgs_height)
    neo = @content
    if $("#temp_textarea")[0]
      matrix = $("#temp_textarea")
    else
      matrix = $("#preview")
    @calculate_scroll(neo, matrix, imgs_height)

  calculate_scroll:(neo, matrix, imgs_height)->
    real_height = matrix[0].scrollHeight + imgs_height
    if real_height > neo[0].scrollHeight
      r = real_height / neo[0].scrollHeight
      matrix.scrollTop(neo.scrollTop() * r)
    else
      matrix.scrollTop(neo.scrollTop())
    #console.log "neo:", neo.scrollTop(), " matrix:", matrix.scrollTop()
    #console.log neo[0].scrollHeight, "|", matrix[0].scrollHeight, imgs_height
  
  add_link: =>
    @add_content_to_pos("[]()", 1)
  add_strong: =>
    @add_content_to_pos("****", 2)
  add_italic: =>
    @add_content_to_pos("__", 1)
