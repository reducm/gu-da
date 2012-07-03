class window.Draft
  constroctor:(@timestamp,@title,@content)->
  this.save = ()->
    store.get('')

Draft::update = (timestamp, title, content)->
  draft = new this(timestamp, title,content)
  this.save()

Draft::find = (timestamp)->
