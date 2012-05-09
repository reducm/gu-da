
catagory_operate = (obj) ->
  Jajax::callback obj
  #  cs = $("#catagories")
  #  cs.html("")
  #  for c in obj
  #    cs.append(wrap_catagory c)
  #  bind_ajax()
    
wrap_catagory = (obj) ->
  $("<h3>#{obj.name} #{catagory_delete_link(obj)}</h3>")

bind_ajax = ()->
  $("#catagories a").each((i)->
    $(this).live("ajax:success", (event, data)->
      catagory_operate data
    )
  )


catagory_delete_link = (obj) ->
  "<a href=\"/blog/catagories/#{obj.id}\" data-method=\"delete\" data-remote=\"true\" data-type=\"json\" rel=\"nofollow\" >x</a>"

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

