$(document).ready(->
  button = $("#switch_sidebar_button")
  article = $("#article")
  sidebar = $("#sidebar")
  comment = $('#comment')
  icon = button.find("i")
  #oah = $("#article").height()
  #osh = $("#article").height()
    
  $(".article_each").on("mouseover mouseout",->
    if guda.action == 'index'
      #$(this).toggleClass("hover_background")
      a = $(this).find("a[data-toggle='delete']")
      a.toggle()
  )

  $(".comment_each").on("mouseover mouseout",->
    $(this).toggleClass("hover_background")
  )

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
    icon.toggleClass('icon-chevron-right')
    icon.toggleClass('icon-chevron-left')
    sidebar.toggle()
    button.toggleClass('button_return')
    set_height()
  )
  
  get_notifications = ()->
    if guda.user_id != 0
      $.ajax(
        url:"/users/#{guda.user_id}/notifications"
        type: "get"
        dataType: "json"
        success:(data)->
          if typeof data.count == 'number' && data.count > 0
            $("#notification_li").html("<a href='#{data.path}'><span class='badge jbadge-info'>#{data.count}</span></a>")
      )

  if guda.user_id != 0
    setInterval(get_notifications, 300000)

  set_height = ()->
    if article.height() < sidebar.height()
      if sidebar.is(":visible")
        article.height(sidebar.height())
    if guda.action == 'index'
      button.height(article.outerHeight())
    else
      button.height($("#articles").height())

  
  if window.action != 'index' && button[0]
    button.click()
)


