# encoding: UTF-8
class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :catagory
  has_many :article_tagships
  has_many :tags, :through => :article_tagships 
  has_many :replies

  attr_accessible :title, :content

  validates :user_id, :presence => {:message => '当前用户已过期，请重新登录' }
  validates :title, :presence => { :message => '题目不能为空' }#, :length=>{ :minimum=>5, :maximum=>100, :message => '题目长度在6-20之间'  } 
  validates :content, :presence => { :message =>'内容不能为空' } 

  before_save :set_preview

  def self.get_index(user_id)
    select("id, preview, created_at, title").where("user_id=?", user_id).order("created_at desc")
  end

  private
  def set_preview
    self.preview = "#{self.content.first(140)}..." #为文章内容加入preview，头140字
  end
  
end
