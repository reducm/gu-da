#encoding: utf-8
class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  
  attr_accessible :user_id, :content, :article_id, :visitor_name, :visitor_email
  
  validates :article_id, :presence => true 
  validate :validate_email
  validate :validate_visitor_name
  validates :content, :presence => {:message => '评论内容不能为空' } 
  has_many :notifications, :as => :senderable
  
  attr_accessor :user_name

  def self.get_by_article_id(id)
    cs = Comment.select('id, content, created_at, user_id, visitor_name').where("article_id=?", id).order("created_at asc").all
    cs.each do |c|
      if c.user_id !=0
        c.user_name = User.find(c.user_id).name
      else
        c.user_name = c.visitor_name
      end
    end
    cs
  end

  private
  def validate_email
    if ( visitor_email !~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i) && user_id == 0
      errors[:visitor_email] << 'email格式不正确'
    end
  end

  def validate_visitor_name
    if user_id == 0 && (visitor_name.blank?)
      errors[:visitor_name] << '访客名称不能为空'
    end
  end
end

