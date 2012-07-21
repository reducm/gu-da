class window.Draft
  constructor:(@timestamp,@title,@content,@manual=false)->
    @user_name = window.guda.user_name
    window.draft_str = "#{@user_name}_draft"
    this.init()
    @date = Jtime::time_at(@timestamp)

  init:()->
    draft = store.get(draft_str)
    if typeof draft[@timestamp] == 'undefined' || draft[@timestamp] == null
        draft[@timestamp] = {}
    store.set(draft_str,draft)

  save:()->
      draft = store.get(draft_str)
      temparr = []
      map_draft(draft, (timestamp, draft_hash)=>
        if draft_hash.manual == this.manual
          temparr.push(timestamp)
      )
      if temparr.length >= 10 #保证数组长度是10
        count = temparr.length - 10 + 1
        for i in [1..count]
          delete draft[temparr.pop()]
      draft[@timestamp]['title'] = @title
      draft[@timestamp]['content'] = @content
      draft[@timestamp]['manual'] = @manual
      store.set(draft_str, draft)

  check:()->
    if @content.length > 50 && @content.length % 60 == 0
      this.save()
    
    
  update_attributes:(timestamp,title,content)->
      @timestamp = timestamp
      @title= title
      @content = content
      @date = Jtime::time_at(@timestamp)
      draft = store.get(draft_str)
      if draft[@timestamp]?
          draft[@timestamp]['title'] = @title
          draft[@timestamp]['content'] = @content
          store.set(draft_str, draft)
      else
          false


Draft::update = (timestamp, title, content)->
  draft = new Draft(timestamp, title,content)
  draft.check()

Draft::find = (timestamp)->
    draft = store.get(draft_str)
    d = draft[timestamp]
    new Draft(timestamp,d.title,d.content,d.manual)

Draft::all = ()->#返回一个包装好的Draft由小到大的数组
    draft = store.get(draft_str)
    ds = []
    map_draft(draft, (k, v)->
        ds.push(new Draft(k, v.title, v.content, v.manual))
    )
    ds

Draft::destroy = (timestamp)->
    draft = store.get(draft_str)
    if typeof draft[timestamp] == 'undefined' || draft[timestamp] == null
      false
    else
      delete draft[timestamp]
      store.set(draft_str,draft)
      true

#遍历draft提供出来的draft, yield出的是由新到旧排好序的草稿
map_draft = (draft, fn)->
  array = []
  for k,v of draft
    array.push(parseInt(k))
  array = Jarray::sort(array,true)
  array.reverse()
  for i in array
    fn(i, draft[i])


