class Blog.CommentsController extends Spine.Controller
  elements:
    '#comments':'comments_div'

  constructor: ->
    super
    @markdown = new Showdown.converter()
    @init_view()
    @set_waypoint()
    Comment.bind('refresh', @fill_comments)
    Comment.bind('ajaxSuccess', @fill_comments)
    #Comment.bind('create', @append_comment)
    @button.on('click', @create_comment)

#private
  init_view: ()=>
    @comments_div.append(@view 'comments/form')
    @form_div = $("#comment_form")
    @form = $("#new_comment")
    @textarea = $("#comment_textarea")
    @textarea.editor()
    @button = $("#comment_commit_button")
    that = @
    @textarea.bind('focus', ->
      that.button.show('fast')
      that.button.css('display', 'inline-block')
      $("#visitor_name").show('fast')
      $("#visitor_email").show('fast')
      $(this).animate({height: '80px'},'fast')
    )

  set_waypoint: ()=>
    waypoint = "<div class='.waypoint'></div>"
    that = @
    $(waypoint).waypoint((event,direction)->
      if direction == 'down'
        Comment.fetch()
        $(this).waypoint('destroy')
    )
    @comments_div.append($(waypoint))

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
    
    
Comment = Blog.Comment
