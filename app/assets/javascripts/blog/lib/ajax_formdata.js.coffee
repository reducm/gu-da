Blog.ajax_formdata = {
  ajax_formdata:(url, formdata,callback)->
    $.ajax({
      url:url
      type:"POST"
      data:formdata
      success:(data)->
        Jajax::callback(data, callback)
      processData:false
      contentType:false
    })
}
