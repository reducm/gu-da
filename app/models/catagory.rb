#encoding: UTF-8
class Catagory < ActiveRecord::Base
  has_many :articles
  belongs_to :user

  attr_accessible :user_id, :name, :pid
  validates :user_id, :presence => {message:'用户不能为空'} 
  validates :name, :presence => {message:'名称不能为空'}
end
