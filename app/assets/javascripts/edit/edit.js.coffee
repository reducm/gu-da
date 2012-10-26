$(document).ready(()->
  fix_container_height = (e)->
    bh = body.height()
    nh = nav.height()
    article.height(bh - nh - 40 )
    #ah = article.height()
    #aeh = ae.eight()
    #content.height( ah - aeh)
    #console.log("ah:", ah, "\n", "aeh:", aeh, "\ncontent_height", ah - aeh)


  article = $("#article")
  content = $("#article_content")
  ae = $("#article_edit")
  nav = $("#navbar")
  body = $("body")


  fix_container_height()
  $(window).on("resize",fix_container_height)

)


