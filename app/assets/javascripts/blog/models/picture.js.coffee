class Blog.Picture extends Spine.Model
  @configure 'Picture', 'pictureable_type', 'pictureable_id', 'file', 'url'
  @extend Spine.Model.Ajax
