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
    if typeof timestamp == 'string'
      timestamp = parseInt(timestamp)
    d = new Date(timestamp)
    "#{d.getMonth()+1}月#{d.getDate()}日 #{d.getHours()}:#{d.getMinutes()}"

class window.Jarray
  #冒泡排序,要插原生javascript...,to_s是排序后元素是否转换回string, 由小到大排列
  Jarray::sort = (array,to_s=false)->
    array =
    `function(array,to_s){
      var l = array.length;
      var i = 0;
      var j = 0;
      for(i;i<l;i++) {
        for(j=i+1;j<l;j++) {
          if (array[j] < array[i]) {
            var temp = array[j];
            array[j] = array[i];
            array[i] = temp ;
          }
        }
      }
      return array;
     }(array,to_s);`
    if to_s
      for element, i in array
        array[i] = element.toString()
    array


