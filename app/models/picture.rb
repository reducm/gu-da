#encoding: utf-8
class Picture < ActiveRecord::Base
  mount_uploader :file, PictureUploader
  belongs_to :pictureable, :polymorphic => true 

  validates :file, :presence => true 
  validates :pictureable, :presence => true 
#  validates_numericality_of :file_size, :less_than_or_equal_to => 3072000, :message => "图片容量不能大于3M" 

  before_save :set_file_name_type_size

  protected
  def set_file_name_type_size
    self.file_name = file.file.original_filename
    self.file_type = file.file.content_type
    self.file_size = file.file.size
  end
end
