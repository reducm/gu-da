class Blog.CommentsController extends Spine.Controller
  elements:
    '#comments':'comments_div'
  # events:
  #   'click .item': 'itemClick'

  constructor: ->
    super
    @init_view()

#private
  init_view: ()=>
    @comments_div.append(@view 'comments/form')
