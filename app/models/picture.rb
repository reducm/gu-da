class Picture < ActiveRecord::Base
  mount_uploader :file, PictureUploader
  belongs_to :pictureable, :polymorphic => true 

  validate :file, :presence => true 
  validate :pictureable, :presence => true 

  before_save :set_file_name_type_size

  protected
  def set_file_name_type_size
    self.file_name = file.file.original_name
    self.file_type = file.file.content_type
    self.file_size = file.file.size
  end
end
