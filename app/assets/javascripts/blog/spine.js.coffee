#= require json2
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib

#= require_self
class Blog extends Spine.Controller
  constructor: ->
    super
    
    @append(@pages = new Blog.Pages)
    
    Blog.Page.one 'refresh', ->
      Spine.Route.setup()

window.Blog = Blog

