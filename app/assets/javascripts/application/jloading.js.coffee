$.fn.extend({ #自己写的loading扩展,会在元素上面加一个透明dark_bg,显示正在loading,然后可以unloading取消这个状态
  loading: ()->
    return false unless this[0]
    div = $("<div class='jloading'>loading<span class='loading_text'></span></div>")
    div.width(this[0].offsetWidth).height(this[0].offsetHeight)
    this.css("position","relative")
    div.css({position:"absolute", top:0, left:0, background:"black", opacity:0.7,"z-index:999",color:"white"})
    this.append(div)
    span = div.find("span")
    tempfunc = ()->
      dots = span.text()
      if dots.length < 3
        span.text("#{dots}.")
      else
        span.text(".")
    interval_id = setInterval(tempfunc,700)
    span.attr("interval", interval_id)
  unloading: ()->
    div = this.find(".jloading")
    clearInterval(div.find("span").attr("interval"))
    div.remove()
})


