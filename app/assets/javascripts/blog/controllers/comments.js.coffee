class Blog.CommentsController extends Spine.Controller
  elements:
    '#comments':'comments_div'

  constructor: ->
    super
    @init_view()
    @set_waypoint()
    Spine.bind("fill.comments", @fill_comments)
    @button.on('click',()=>
      c = new Comment()
      c.article_id = guda.article_id
      c.user_id = guda.user_id
      form_arr = @form.serializeArray()
      _.each(form_arr,(attr)->
        c[attr.name] = attr.value
      )
      console.log(c)
    )

#private
  init_view: ()=>
    @comments_div.append(@view 'comments/form')
    @form_div = $("#comment_form")
    @form = $("#new_comment")
    @textarea = $("#comment_textarea")
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
    cs = Comment.all()
    markdown = new Showdown.converter()
    @form_div.after(@view("comments/each")({comments:cs, markdown:markdown}))

Comment = Blog.Comment
