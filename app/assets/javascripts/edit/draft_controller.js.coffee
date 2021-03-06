$(document).ready(->
  article = $("#article")
  preview = $("#preview")
  content = $("#article_content")
  title = $("#article_title")
  draft_div = $('#draft')

  dc = new DraftController(title,content,draft_div)
)

class DraftController
  constructor:(@title,@content,@draft_div)->
    @user_name = window.guda.user_name
    window.draft_str = "#{@user_name}_draft"
    this.init()
    that = this
    @converter = new Showdown.converter()
    @modal_body = @draft_div.find('.modal-body')
    @content.bind('keyup',()=>
      this.update(@title.val(), @content.val())
    )
    @draft_div.bind('shown',()=>
      this.show()
    )
    $("a[data-toggle='save-draft']").bind('click',()=>
      draft = new Draft(@timestamp, @title.val(), @content.val(),true)
      draft.save()
      @draft_div.modal('show')
      $.pnotify({text:"草稿创建成功",type:"success"})
    )
    @draft_div.delegate('tr','restore',()->
        that.restore($(this).attr('timestamp'))
    ).delegate('tr','delete',()->
        that.destroy($(this))
    )
    @draft_div.delegate('tr', 'mouseenter mouseleave', ()->
      $(this).find('td:last div').toggle()
    )
    @draft_div.delegate('a[data-toggle]','click',()->
        $(this).parents("tr").trigger($(this).attr('data-toggle'))
    )

  init:()->
    @timestamp ?= Date.now()
    draft = store.get(draft_str)
    if (typeof draft == 'undefined' || draft == null)
      draft = {}
    store.set(draft_str,draft)

  update:(title,content)->
    Draft::update(@timestamp, title, content)

  restore:(timestamp)->
    draft = Draft::find(timestamp)
    @title.val(draft.title)
    @content.val(draft.content)
    jalert("恢复成功", "success", @modal_body)
    $.pnotify({text:"恢复成功", type:"success"})

  destroy:(element)->
    timestamp = element.attr('timestamp')
    if Draft::destroy(timestamp)
        element.remove()
        try
          $("#draft_#{timestamp}").remove()
        catch Exception
        jalert("删除成功", "success", @modal_body)

  show:()->
    ds = Draft::all()
    div = @draft_div.find('.modal-body')
    atbody = $("<tbody></tbody>")
    mtbody = $("<tbody></tbody>")
    $("#draft_username").html("#{@user_name}的草稿")
    for draft, i in ds
      content=""
      try
        content = @converter.makeHtml(draft.content)
      catch error
        content = draft.content
        
      tr = wrap_tr(draft,content, @converter)
      if draft.manual
        mtbody.append(tr)
      else
        atbody.append(tr)
    build_table($("#automatic_draft"),atbody)
    build_table($("#manual_draft"),mtbody)

operate_title = (title)->
  title = $.trim(title)
  if title? && title.length!=0
    return title
  else
    return '无题目'

build_table = (element, tbody)->
  element.find("table").remove()
  element.append("<table class='table table-condensed'><thead><tr><th>日期</th><th>题目</th><th></th></tr></thead></table>")
  element.find("table").append(tbody)

wrap_tr = (draft,content,converter)->
    tr = $("<tr timestamp='#{draft.timestamp}'><td>#{draft.date}</td><td>#{operate_title(draft.title)}</td><td><div class='hide'>#{restore()}|#{del()}</div></td></tr>")
    tr.bind('click', (event)->
      div
      if $("#draft_#{draft.timestamp}")[0]?
        div = $("#draft_#{draft.timestamp}")
      else
        div = $("<tr id='draft_#{draft.timestamp}'><td colspan=\"3\">#{converter.makeHtml(draft.content)}</td></tr>")
        tr.after(div)
        div.hide()
        div.bind('click',-> $(this).toggle('fast'))
      div.toggle('fast')
    )
    tr

restore = ()->
    "<a href=\"#\" data-toggle=\"restore\">恢复</a>"

del = ()->
    "<a href=\"#\" class=\"del_link\" data-toggle=\"delete\">删除</a>"

jalert = Jalert::alert
