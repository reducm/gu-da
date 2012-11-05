#= require json2
#= require spine
#= require spine/manager
#= require spine/local
#= require spine/ajax
#= require spine/route
#
#= require_self
#= require_tree ./lib
class Blog extends Spine.Controller
  constructor: ->
    super
    
    #@append(@pages = new Blog.Pages)
    
    #Blog.Page.one 'refresh', ->
    Spine.Route.setup()

window.Blog = Blog

