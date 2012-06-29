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

class window.Jtime
  Jtime::time_at = (timestamp) ->
    d = new Date(timestamp)
    "#{d.getMonth()+1}月#{d.getDate()}日 #{d.getHours()}:#{d.getMinutes()}"
  
class window.Jarray
  Jarray::sort = (array)->
    `
    l = array.length;
    var i = 0;
    var j = 0;
    for(i;i<l;i++) {
      for(j=i+1;j<l;j++) {
        if (j < i) {
          var temp = array[j];
          array[j] = array[i];
          array[i] = temp ;
        }
      }
    }
    return array;
  `

