$(document).ready(->
  button = $("#switch_sidebar_button")
  article = $("#article")
  sidebar = $("#sidebar")
  icon = button.find("i")
  button.bind('mouseover', ->
    article.addClass('right_shadow')
  )
  button.bind('mouseout', ->
    article.removeClass('right_shadow')
  )
  button.bind('click',->
    article.toggleClass('article_normal_width')
    article.toggleClass('article_edit_width')
    icon.toggleClass('icon-forward')
    icon.toggleClass('icon-backward')
    sidebar.toggle()
  )
)
