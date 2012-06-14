#encoding: utf-8
require_dependency 'jas/jnotify'
class Comment < ActiveRecord::Base
  include JNotify
  belongs_to :user
  belongs_to :article
  
  attr_accessible :user_id, :content, :article_id, :visitor_name, :visitor_email
  
  validates :article_id, :presence => true 
  validate :validate_visitor_email
  validate :validate_visitor_name

  validates :content, :presence => {:message => '评论内容不能为空' } 
  has_many :notifications, :as => :senderable
  
  attr_accessor :user_name, :user_picture, :strtime

  def self.get_by_article_id(id)
    cs = Comment.includes(user:[:picture]).select('id, content, created_at, user_id, visitor_name').where("article_id=?", id).order("created_at asc").all
    cs.each do |c|
      if c.user != nil
        c.user_name = c.user.name
      else
        c.user_name = c.visitor_name
      end
    end
    cs
  end

  def get_user_name
    self.visitor_name || self.user.name
  end

  private
  def validate_visitor_email
    if visitor_email.nil? && user_id ==0
      errors[:visitor_email] << 'Email不能为空'
    elsif( visitor_email !~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i) && user_id == 0
      errors[:visitor_email] << 'Email格式不正确'
    end
  end

  def validate_visitor_name
    if user_id == 0 && visitor_name.nil?
      errors[:visitor_name] << '昵称不能为空'
    elsif user_id ==0 && (visitor_name.length<3 || visitor_name.length >15)
      errors[:visitor_name] << '昵称长度要在3-15之间'
    end
  end
end

