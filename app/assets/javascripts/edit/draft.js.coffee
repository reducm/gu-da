class window.Draft
  constructor:(@timestamp,@title,@content)->
    this.init()
    @date = Jtime::time_at(@timestamp)

  init:()->
    draft = store.get('draft')
    if typeof draft[@timestamp] == 'undefined' || draft[@timestamp] == null
        draft[@timestamp] = {}
    store.set('draft',draft)

  save:()->
    if @content.length > 50 && @content.length % 60 == 0
        draft = store.get('draft')
        draft[@timestamp]['title'] = @title
        draft[@timestamp]['content'] = @content
        store.set('draft', draft)
    
  update_attributes:(timestamp,title,content)->
      @timestamp = timestamp
      @title= title
      @content = content
      @date = Jtime::time_at(@timestamp)
      draft = store.get('draft')
      if draft[@timestamp]?
          draft[@timestamp]['title'] = @title
          draft[@timestamp]['content'] = @content
          store.set('draft', draft)
      else
          false


Draft::update = (timestamp, title, content)->
  draft = new Draft(timestamp, title,content)
  draft.save()

Draft::find = (timestamp)->
    draft = store.get('draft')
    draft[timestamp]

Draft::all = ()->#返回一个包装好的Draft由小到大的数组
    #便利draft提供出来的draft, yield出的是由新到旧排好序的草稿
    map_draft = (draft, fn)->
      array = []
      for k,v of draft
        array.push(parseInt(k))
      array = Jarray::sort(array,true)
      array.reverse()
      for i in array
        fn(i, draft[i])

    draft = store.get('draft')
    ds = []
    map_draft(draft, (k, v)->
        ds.push(new Draft(k, v.title, v.content))
    )
    ds

