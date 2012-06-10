#专用于处理返回的ajax数据
class window.Jajax

Jajax::callback = (data, operator)->
    if data.errors?
      Jajax::error_dealer(data.errors)
      false
    else
      operator(data)

Jajax::error_dealer = (message)->
  console.log(message)
  error_modal(message)

error_modal =(message)->
  errorModal=$("#errorModal")
  if errorModal[0]?
    errorModal.find('.modal-body p').html(message)
  else
    str= """
    <div class="modal hide" id="errorModal">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h3>出错了!</h3>
      </div>
      <div class="modal-body">
        <p>#{message}</p>
      </div>
      <div class="modal-footer">
        <a href="#" class="btn btn-danger" data-dismiss="modal">确定</a>
      </div>
    </div>
    """
    errorModal = $(str).modal('hide')
  errorModal.modal('show')

