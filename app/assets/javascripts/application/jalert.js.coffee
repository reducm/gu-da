class window.Jalert

#输出信息
Jalert::alert = (str, type='info',element="#flash") ->
  element = $(element) if typeof element == 'string'
  inside(str, type, element)

inside = (str,type,element)->
  element.find(".alert").remove()
  element.prepend(wrap(type,str))

wrap = (type, str)->
  div = """
          <div class="alert alert-#{type}">
            <a class="close" data-dismiss="alert" href="#">×</a>
            #{str}
          </div>
        """
