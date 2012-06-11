$(document).ready(()->
  if $('.error').size() > 0
    $('.error input').each(->
      $(this).bind('focus', ->
        $(this).parents('.error').removeClass('error')
        $(this).next('span').remove()
      )
    )

  $('#edit_user_left').find('a').click((e)->
    e.preventDefault()
    $(this).tab('show')
  )

  $("#user_description").count_num(140)
)

$.fn.extend({
  count_num : (num)->
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
