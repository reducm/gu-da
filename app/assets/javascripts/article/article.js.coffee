$(document).ready(->
  button = $("#switch_sidebar_button")
  article = $("#article")
  sidebar = $("#sidebar")
  comment = $('#comment')
  icon = button.find("i")
  oah = article.height()
  osh = article.height()

  button.bind('mouseover', ->
    #    article.addClass('right_shadow')
    button.addClass('bg_darker')
  )
  button.bind('mouseout', ->
    #article.removeClass('right_shadow')
    button.removeClass('bg_darker')
  )
  button.bind('click',->
    article.toggleClass('article_normal_width')
    article.toggleClass('article_edit_width')
    comment.toggleClass('article_normal_width')
    comment.toggleClass('article_edit_width')
    icon.toggleClass('icon-forward')
    icon.toggleClass('icon-backward')
    sidebar.toggle()
    button.toggleClass('button_return')
    set_height()
  )
  
  set_height = ()->
    if article.height() < sidebar.height()
      if sidebar.css("display") == "block"
        article.height(sidebar.height())
    button.height(article.height())

  set_height()
  
  if window.action != 'index' && button[0]
    button.click()
)


