class window.Jalert

#输出信息，第一个参数是信息选项'danger info success',第二个是信息， 第三个是放在哪一个节点的上方,没有第三个参数的话默认放在#flash里头
Jalert::alert = (type='info', str, element) ->
  $("#flash").append(wrap(type,str))

wrap = (type, str)->
  div = """
          <div class="alert alert-#{type}">
            <a class="close" data-dismiss="alert" href="#">×</a>
            #{str}
          </div>
        """

