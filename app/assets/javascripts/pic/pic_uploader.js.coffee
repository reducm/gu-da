class window.PicUploader
  constructor:(@action,@formdata,@callback)->
  upload: ()->
    that = this
    $.ajax({
      url:that.action,
      type:"POST",
      data:that.formdata,
      success:that.callback,
      processData:false,
      contentType:false
    })
