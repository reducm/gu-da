$.rails.confirm = (message)->
  confirm(message)
  
$.rails.allowAction = (link) ->
  unless link.attr('data-confirm')
    if link.attr('jdata-confirm')?
      message = link.attr('jdata-confirm')
      link.attr('data-confirm', message)
    return true
  this.showConfirmDialog(link)
  false

$.rails.confirmed = (link) ->
  message = link.attr('data-confirm')
  link.attr('jdata-confirm', message)
  link.removeAttr('data-confirm')
  link.trigger('click.rails')


$.rails.showConfirmDialog = (element, id="delete_confirm")->
  message = element.attr('data-confirm')
  template = $(id)
  unless template[0]
    template = JST['application/modal'](message:message, id:id)
    template = $(template)
    $("body").append(template)
  ok_button = template.find("a[data-bind='ok']")
  cancel_button = template.find("a[data-bind='cancel']")
  ok_button.on("click", ()->
    $.rails.confirmed(element)
    template.modal('hide')
  )
  cancel_button.on("click", ()->
    template.modal('hide')
  )
  template.modal()



  
