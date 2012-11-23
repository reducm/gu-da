#encoding: UTF-8
class Catagory < ActiveRecord::Base
  has_many :articles
  belongs_to :user

  attr_accessible :user_id, :name, :pid, :id
  validates :user_id, presence: {message:'用户不能为空'} 
  validates :name, presence: {message:'名称不能为空'}, uniqueness: {scope: :user_id, message: "这个分类已存在" } 

  def self.get_all(user_id) #暂未处理取出文章数
    catagories = []
    catagories += select("id, name, user_id").where("user_id=?", user_id).order("created_at asc")
    catagories << self.new(id:0, name:'默认分类', user_id: user_id)
    catagories
  end

  def self.default(user_id=0)
    self.new(name:"默认分类", id:'0', user_id:user_id)
  end
end
