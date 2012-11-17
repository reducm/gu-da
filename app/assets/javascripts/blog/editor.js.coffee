#= require ./controllers/drafts
#= require ./controllers/editor

$(document).ready ()->
  guda.controllers.push(new Blog.EditorController({el:"#container"}))


