$("#catagory_form").live("ajax:success",
  (event, data)->
    catagory_operate data
)

catagory_operate = (obj) ->
  str = ''
  for c in obj
    str += wrap_catagory c
  $("#catagories").html(str)

wrap_catagory = (obj) ->
  "<h3>#{obj.name} #{catagory_delete_link(obj)}</h3>"

catagory_delete_link = (obj) ->
  "<a href=\"/blog/catagories/#{obj.id}\" data-method=\"delete\" data-remote=\"true\" data-type=\"json\" rel=\"nofollow\" >x</a>"
