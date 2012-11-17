$ = jQuery.sub()
Draft = Blog.Draft

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Draft.find(elementID)

class Blog.Drafts extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/drafts/new':      'new'
    '/drafts/:id/edit': 'edit'
    '/drafts/:id':      'show'
    '/drafts':          'index'
    
  default: 'index'
  className: 'stack drafts'
