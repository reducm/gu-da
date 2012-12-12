#= require ./models/comment
#= require ./controllers/comments
#= require_tree ./views/comments

$(document).ready(()->
  article_id = guda.article_id
  user_id = guda.user_id
  window.guda.controllers.push(new Blog.CommentsController({el:"#comment", article_id:article_id, user_id: user_id }))
)

