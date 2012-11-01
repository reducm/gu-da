#专用于处理返回的ajax数据
class window.Jajax

Jajax::callback = (data, operator)->
    if data.errors?
      Jajax::error_dealer(data.errors)
      false
    else
      operator(data)

Jajax::error_dealer = (message)->
  console.log(message)
  $.pnotify({text:message, type:'error'})
  
