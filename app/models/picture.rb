#encoding: utf-8
class Picture < ActiveRecord::Base
  paginates_per 8
  mount_uploader :file, PictureUploader
  belongs_to :pictureable, polymorphic: true 

  validates :file, presence: true 
  validates :pictureable, presence: true 
#  validates_numericality_of :file_size, :less_than_or_equal_to => 3072000, :message => "图片容量不能大于3M" 

  before_save :set_file_name_type_size
  before_destroy :remember_storedir
  after_destroy :remove_storedir

  def self.get_index(params)
    where("pictureable_type='User' and pictureable_id=?", params[:user_id]).order("id desc").page(params[:page] || 1)
  end

  protected
  def set_file_name_type_size
    self.file_name = file.file.original_filename
    self.file_type = file.file.content_type
    self.file_size = file.file.size
  end

  def remember_storedir
    @storedir = File.join(Rails.root, 'public',self.file.store_dir)
  end

  def remove_storedir
    FileUtils.remove_dir(@storedir,force:true)
  end
end
