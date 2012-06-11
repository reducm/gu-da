$(document).ready(->
  button = $("#switch_sidebar_button")
  article = $("#article")
  sidebar = $("#sidebar")
  comment = $('#comment')
  icon = button.find("i")

  button.height(article.height())

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
  )

#  sidebar.height(article.height()) if article.height() > sidebar.height()
)
