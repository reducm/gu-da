class window.Jalert

#输出信息
Jalert::alert = (str, type='info',element="#flash") ->
  if element == "#flash"
    inside(str,type,element)
  else
    above(str,type,element)

above = (str,type,element)->
  parent = $(element).parent()
  parent.find('.alert').remove()
  parent.prepend(wrap(type,str))

inside = (str,type,element)->
  $(element).empty()
  $(element).append(wrap(type,str))

wrap = (type, str)->
  div = """
          <div class="alert alert-#{type}">
            <a class="close" data-dismiss="alert" href="#">×</a>
            #{str}
          </div>
        """

