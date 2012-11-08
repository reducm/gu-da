$.rails.confirm = (message)->
  template = JST['application/modal'](message:message)
  template = $(template)
  $("body").append(template)
  template.modal()
  false
  
