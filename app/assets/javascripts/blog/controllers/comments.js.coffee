class Blog.CommentsController extends Spine.Controller
  elements:
    '#comments':'comments_div'

  constructor: ->
    super
    @init_view()
    @set_waypoint()
    #后台读数据 waypoint给each

#private
  init_view: ()=>
    @comments_div.append(@view 'comments/form')

  set_waypoint: ()=>
    waypoint = "<div class='.waypoint'></div>"
    $(waypoint).waypoint((event,direction)=>
      @load_comments()
    )
    @comments_div.append($(waypoint))

  load_comments: ()=>
    Comment.fetch()
    cs = Comment.all()
    console.log(cs)
    @fill_comments(cs)

  fill_comments: (cs)=>
    helper:
      show_user_head:(comment)->
        #if comment



Comment = Blog.Comment
