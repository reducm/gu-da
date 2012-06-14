module JNotify
  def self.included(receiver)
    receiver.send :after_commit, :notify
  end
  
  def notify
    user_id = Article.select("user_id").find(self.article_id)
    Notification.create(senderable:self, receiver_id:user_id, content:"fuck")
  end
end

