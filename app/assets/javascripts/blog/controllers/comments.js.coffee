class Blog.CommentsController extends Spine.Controller
  elements:
    '#comments':'comments_div'

  constructor: ->
    super
    @markdown = new Showdown.converter()
    Comment.url = "/articles/#{guda.article_id}/comments"
    @init_view()
    @set_waypoint()
    Comment.bind('refresh', @fill_comments)
    Comment.bind('ajaxSuccess', @fill_comments)
    Comment.bind('destroy', @destroy)
    @button.on('click', @create_comment)

#private
  init_view: ()=>
    @comments_div.prepend(@view 'comments/form')
    @form_div = $("#comment_form")
    @form = $("#new_comment")
    @textarea = $("#comment_textarea")
    @textarea.editor()
    @button = $("#comment_commit_button")
    that = @
    @textarea.on('focus', ->
      that.button.show('fast')
      that.button.css('display', 'inline-block')
      $("#visitor_name").show('fast')
      $("#visitor_email").show('fast')
      $(this).animate({height: '80px'},'fast')
    ).on("keyup", (e)->
      that.button.click() if (e.ctrlKey && e.which == 13 || e.which == 10)
    )

    $(".comment_each").live("mouseenter mouseleave",()->$(this).find(".comment_reply").toggle())

    $(".comment_each .comment_reply a[data-toggle='reply_comment']").live('click',()->
      name = $(this).parent().prev('.comment_name').text()
      textarea = that.textarea
      ov = textarea.val()
      textarea.val("@#{name} #{ov}")
      textarea.setCurPos(textarea.val().length)
      textarea.focus()
    )

    $(".comment_each .comment_reply a[data-toggle='delete_comment']").live('click',()->
      comment_each = $(this).parents(".comment_each")
      c = Comment.find(comment_each.data("comment-id"))
      c.destroy()
    )

  set_waypoint: ()=>
    waypoint = "<div class='.waypoint'></div>"
    @comments_div.append($(waypoint))
    that = @
    $(waypoint).waypoint((event,direction)->
      if direction == 'down'
        Comment.fetch()
        $(this).waypoint('destroy')
    ,{offset:'100%'})

  fill_comments: ()=>
    $(".comment_each").remove()
    cs = Comment.all()
    #amazing coffeescript,下面这行这样写居然是返回for循环里面的累计集合,不过应该有问题
    @form_div.after(
      for c,i in cs
        @view("comments/each")({comment:c, markdown:@markdown, index: i })
    )

  create_comment: ()=>
    attr_hash = {article_id: guda.article_id, user_id: guda.user_id, user_head:guda.user_head }
    form_arr = @form.serializeArray()
    _.each(form_arr,(attr)->
      attr_hash[attr.name] = attr.value
    )
    @button.loading()
    Comment.create_from_ajax( "/articles/#{guda.article_id}/comments", comment:attr_hash, @append_comment)

  append_comment: (comment)=>
    @button.unloading()
    @textarea.val("")
    @comments_div.append @view("comments/each")({comment:comment, markdown:@markdown, index: comment.id })
    set_location("#comment_#{comment.id}")

  destroy: (model)=>
    $(".comment_each[data-comment-id='#{model.id}']").remove())

    
    
Comment = Blog.Comment
