class Blog.Comments extends Spine.Controller
  elements:
   '#comment': 'comment_div'
   '#comments': 'comments_div'
   '#comment_textarea': 'textarea'
   '#comment_commit_button': 'button'
   '#new_comment': 'form'
   
  # events:
  #   'click .item': 'itemClick'

  constructor: ->
    super
