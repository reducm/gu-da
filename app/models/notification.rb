#encoding: utf-8
class Notification < ActiveRecord::Base
  belongs_to :senderable, polymorphic: true  
  belongs_to :user, foreign_key: :receiver_id
  #  validates :content, :presence => {message:"内容不能为空"} 
  validates :senderable, presence: {message:"不能没有发送者"}
  validates :receiver_id, presence: {message:'不能没有接收者'}

  def self.get_all(user_id)
    ns = includes(senderable: [:user]).where("receiver_id=?", user_id).order("created_at desc")
    ns.update_all(readed: true)
    ns
  end

  def self.unread_count(user_id)
    where("receiver_id=? and readed=0 ", user_id).count
  end
end
