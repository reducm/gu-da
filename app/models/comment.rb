#encoding: utf-8
require_dependency 'jas/jnotify'
class Comment < ActiveRecord::Base
  include JNotify
  belongs_to :user
  belongs_to :article
  
  attr_accessible :user_id, :content, :article_id, :visitor_name, :visitor_email
  
  validates :article_id, presence:{message:'不能缺少article_id'}
  validate :validate_visitor_name
  validate :validate_visitor_email

  validates :content, presence: {:message => '评论内容不能为空' } 
  has_many :notifications, as: :senderable
  
  attr_accessor :user_name, :user_picture, :strtime


  def self.get_by_article_id(id)
    cs = Comment.includes(user:[setting:[:picture]]).select('id, content, created_at, user_id, visitor_name, article_id').where("article_id=?", id).order("created_at asc").all
    cs
  end

  def user_name
    self.get_user_name
  end

  def user_head
    self.user.head.file.url
  end

  def guest?
    self.user_id == 0
  end

  def get_user_name
    self.visitor_name || self.user.name
  end

  def to_json(*params)
    json = JSON.parse super(*params)
    json = json.merge({"user_head" => user_head })
    json.to_json
  end

  private
  def validate_visitor_email
    if visitor_email.nil? && user_id ==0
      errors[:visitor_email] << 'Email不能为空'
    elsif( visitor_email !~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i) && user_id == 0
      errors[:visitor_email] << 'Email格式不正确'
    elsif user_id == 0 && User.find_by_email(visitor_email)
      errors[:visitor_email] << 'Email已被注册用户使用'
    end
  end

  def validate_visitor_name
    if user_id == 0 && visitor_name.nil?
      errors[:visitor_name] << '昵称不能为空'
    elsif user_id ==0 && (visitor_name.length<3 || visitor_name.length >15)
      errors[:visitor_name] << '昵称长度要在3-15之间'
    elsif user_id ==0 && User.find_by_nickname(visitor_name)
      errors[:visitor_name] << '昵称已被注册用户使用'
    end
  end
end

