class window.PicUploader
  constructor:(@action,@formdata,@callback)->
  upload: ()->
    that = this
    $.ajax({
      url:that.action
      type:"POST"
      data:that.formdata
      success:(data)->
        Jajax::callback(data, that.callback)
      processData:false
      contentType:false
    })
