#encoding: UTF-8
class Catagory < ActiveRecord::Base
  has_many :articles
  belongs_to :user

  validates :user_id, :presence => {message:'用户不能为空'} 
  validates :name, :presence => {message:'名称不能为空'}
  

end
