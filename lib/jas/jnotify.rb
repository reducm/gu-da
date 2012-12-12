#encoding: utf-8
module JNotify
  def self.included(receiver)
    receiver.send :after_create, :notify
  end


  private
  def notify
    a = Article.select("user_id,title,id").find(self.article_id)
    if a.user_id != self.user_id
      str = "@#{self.get_user_name} 评论了你的文章[**#{a.title}**](#{Rails.application.routes.url_helpers.article_path(a.id)}#comment_#{self.id})\r\n\r\n>*#{self.content.first(50)}...*" #markdown
      Notification.create(senderable:self, receiver_id:a.user_id,content:str)
    end
    notify_reply(a.user_id, a)
  end

  def notify_reply(article_user_id, article)
    result = self.content.scan /@[a-z1-9_]+? /
    if result.size > 0
      result.each do |r|
        r = r.strip.delete('@')
        u = User.select(:id).find_by_nickname(r)
        return if !u || u.id == article_user_id #如果@的人就是这篇文章的作者，就不必在notify多次了
        if u
          str = "@#{self.get_user_name} 在文章 [**#{article.title}**](#{Rails.application.routes.url_helpers.article_path(article.id)}#comment_#{self.id})提到了你\r\n\r\n>*#{self.content.first(50)}...*"
          Notification.create(senderable:self, receiver_id:u.id,content:str)
        end
      end
    else
      nil
    end
  end
end

