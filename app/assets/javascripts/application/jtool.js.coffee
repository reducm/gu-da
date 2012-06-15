$(document).ready(->
  window.original_location = window.location.pathname
)

window.set_location = (str) ->
  ol = window.original_location
  window.location = ol+str

$.fn.extend({ #自己写的扩展textarea的jquery插件，$(node).count_num(limit_num),就会在textarea右上角显示输入数字和剩余
  count_num : (num)->
    return false unless this[0]? #对象不存在return false
    counter = this.prev(".counter")
    unless counter[0]?
      div = $("<div class=\"wrapper\"></div>")
      this.wrap(div)
      this.before("<div class=\"counter\" style=\"margin-left:#{this.width()-15}px\">#{num}</div>")
      counter = this.prev(".counter")
      counter.text(num-this.val().length)
    this.bind("keyup",(e)=>
      str = this.val()
      if (num-str.length)<0
        this.val(str.slice(0,num))
        counter.text(0)
      else
        counter.text(num-str.length)
    )
})
