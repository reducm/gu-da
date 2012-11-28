#encoding: UTF-8
class Page < ActiveRecord::Base
  has_many :pictures, as: :pictureable, dependent: :destroy  
  attr_accessible :content, :title, :user_id, :subtitle, :pictures
  validates :title, uniqueness: {message: '题目不能重复'}, presence: {message: '必须要有标题'}
  validates :subtitle, uniqueness: {message: '富题目不能重复'}, presence: {message: '必须要有副标题'} 
  validates :content, presence: {message: '必须要有内容'}

  def self.get_all
    select("id, subtitle, title, content, updated_at").all
  end

  def self.by_id(id)
    return first if id == 1 || id == '1'
    where("subtitle=?", id)[0] || where("id=?", id)[0]
  end
end
