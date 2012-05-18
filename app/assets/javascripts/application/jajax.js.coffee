#专用于处理返回的ajax数据
class window.Jajax

Jajax::callback = (data, operator)->
    if data.errors?
        Jajax::error_dealer(data)
    else
        operator(data)

Jajax::error_dealer = (data)->
    alert(data.errors)

Jajax::fuck = ()->
    alert("fuck")
