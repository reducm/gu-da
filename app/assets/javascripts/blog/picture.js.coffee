#= require ./models/picture
#= require ./controllers/pictures
#= require_tree ./views/pictures

$(document).ready ()->
  guda.controllers.push(new Blog.PicturesController({el:"#container"}))


