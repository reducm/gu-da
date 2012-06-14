module JNotify
  def self.included(receiver)
    receiver.send :after_create, :notify
  end
  
  def notify
    #user_id = Article.select("user_id").find(self.article_id)
#    Notification.create(senderable:self, receiver_id:user_id, content:"你的文章有新的评论")
  end
end

