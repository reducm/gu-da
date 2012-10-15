class window.Jalert

#输出信息
Jalert::alert = (str, type='info',element="#flash",time=120) ->
  element = $(element) if typeof element == 'string'
  inside(str, type, element, time)

inside = (str,type,element,time)->
  aalert = element.find('.alert')
  if aalert.attr('interval')?
    clearInterval(parseInt(aalert.attr('interval')))
  aalert.remove()
  element.prepend(wrap(type,str,time))

wrap = (type, str,time)->
  div = """
          <div class="alert alert-#{type}">
            <a class="close" data-dismiss="alert" href="#">×</a>
            #{str}　　<span class="backward backward-time">#{time}</span><span class="backward">秒后自动关闭</span>
          </div>
        """
  div = $(div)
  interval = setCountBackward($(div).find(".backward-time"),time)
  div.attr('interval',interval)
  div.find("a").bind('click',()->
    clearInterval(interval)
  )
  div.on("click", ()->
    $(this).alert("close")
  ).on("mouseenter",()->
    $(this).css("cursor","pointer")
  )
  div

#设置倒数,参数{倒数所在的span element, 倒数秒数}
setCountBackward = (element, time)->
  tempfunc = ()->
    if time > 0
      time--
      element.text(time)
    else
      clearInterval(parseInt(element.parent().attr('interval')))
      element.parent().remove()
  setInterval(tempfunc,1000)
