#= require ./models/comment
#= require_tree ./views/comments
#= require ./controllers/comments

$(document).ready ()->
  window.guda.controllers.push(new Blog.CommentsController({el:"#comment"}))


