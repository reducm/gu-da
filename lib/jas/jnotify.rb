#encoding: utf-8
module JNotify
  def self.included(receiver)
    receiver.send :after_create, :notify
  end

  def notify
    a = Article.select("user_id,title,id").find(self.article_id)
    if a.user_id != self.user_id
      str = "@#{self.get_user_name} 评论了你的文章(#{a.title})[#{Rails.application.routes.url_helpers.article_path(a.id)}#comment_#{self.id}]\r\n\r\n>*#{self.content}*"
      Notification.create(senderable:self, receiver_id:a.user_id, content:str)
    end
  end
end

