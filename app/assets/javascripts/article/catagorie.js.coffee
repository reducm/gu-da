$(document).ready(()->
  $("#catagories a").each((i)->
    $(this).live("ajax:success", (event, data)->
      catagory_operate data
    )
  )

  $("#catagory_form").live("ajax:success",
    (event, data)->
      catagory_operate data
  )

  $(".catagory_each").live('mouseenter mouseleave',-> $(this).find("a[data-method='delete']").toggle())

  #$(".catagory_each").live('mouseover',()->
    #$(this).addClass("border_grey")
  #)

  #$(".catagory_each").live("mouseout",()->
    #$(this).removeClass("border_grey")
##    $(this).css({border:'0px'})
  #)

  $("#add_catagory_modal").on('shown', ()->
    $("#catagory_name_input").focus()
  )
)
catagory_operate = (obj) ->
  if window.action == 'new' || window.action == 'edit'
    Jajax::callback obj,catagory_select
  else
    Jajax::callback obj,catagory_sidebar

catagory_select = (obj)->
  cs = $("#catagories_select")
  cs.html("")
  str=""
  for c in obj
    str+=wrap_option_catagory(c)
  cs.html(str)
  $("#add_catagory_modal").modal('hide')
  return


catagory_sidebar = (obj)->
  cs = $("#catagories")
  cs.html("")
  for c in obj
    cs.append(wrap_catagory c)
  bind_ajax()
  $("#add_catagory_modal").modal('hide')
  return

wrap_option_catagory = (obj)->
  "<option value=\"#{obj.id}\">#{obj.name}</option>"

wrap_catagory = (obj) ->
  $("<div class=\"catagory_each\">#{catagory_name_link(obj)} #{catagory_delete_link(obj)}</div>")

bind_ajax = ()->
  $("#catagories a").each((i)->
    $(this).live("ajax:success", (event, data)->
      catagory_operate data
    )
  )

catagory_name_link = (obj)->
  if obj.id == null
    "<a href=\"/users/#{obj.user_id}/catagories/0\">#{obj.name}</a>"
  else
    "<a href=\"/users/#{obj.user_id}/catagories/#{obj.id}\">#{obj.name}</a>"

catagory_delete_link = (obj) ->
  if obj.id != null
    "<a href=\"/catagories/#{obj.id}\" data-method=\"delete\" class=\"pull-right\" data-remote=\"true\" data-type=\"json\" rel=\"nofollow\" >x</a>"
  else
    ""

