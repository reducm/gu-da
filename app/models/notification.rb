class Notification < ActiveRecord::Base
  belongs_to :senderable, :polymorphic => true  
  belongs_to :user, :foreign_key => :receiver_id
  validates :content, :presence => {message:"内容不能为空"} 
  validates :senderable, :presence => true
  validates :senderable, :presence => true
  validates :receiver_id, :presence => {message:'不能没有接收者'}
end
