
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
  $("<h3>#{catagory_name_link(obj)} #{catagory_delete_link(obj)}</h3>")

bind_ajax = ()->
  $("#catagories a").each((i)->
    $(this).live("ajax:success", (event, data)->
      catagory_operate data
    )
  )

catagory_name_link = (obj)->
  if obj.id == null
    "<a href=\"/blog/catagories/0\">#{obj.name}</a>"
  else
    "<a href=\"/blog/catagories/#{obj.id}\">#{obj.name}</a>"

catagory_delete_link = (obj) ->
  if obj.id != null
    "<a href=\"/blog/catagories/#{obj.id}\" data-method=\"delete\" data-remote=\"true\" data-type=\"json\" rel=\"nofollow\" >x</a>"
  else
    ""

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
)

$('#add_catagory_modal').on('show',->
  $('#catagory_name_input').focus()
)
