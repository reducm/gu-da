#encoding: utf-8
class Notification < ActiveRecord::Base
  belongs_to :senderable, :polymorphic => true  
  belongs_to :user, :foreign_key => :receiver_id
  #  validates :content, :presence => {message:"内容不能为空"} 
  validates :senderable, :presence => {message:"不能没有发送者"}
  validates :receiver_id, :presence => {message:'不能没有接收者'}

  def self.get_all(user_id)
    ns = includes(:senderable => [:article,:user]).where("receiver_id=?", user_id)
    ns.update_all(readed:true)
    ns
  end
end
