# encoding: UTF-8
require_dependency 'jas/jredis_counter'
class Article < ActiveRecord::Base
  paginates_per 10 
  belongs_to :user
  belongs_to :catagory
  has_many :article_tagships
  has_many :tags, through: :article_tagships 
  has_many :comments, dependent: :destroy 
  has_many :pictures, as: :pictureable, dependent: :destroy 
  has_many :notifications, as: :senderable

  include Redis::Objects
  include JCounter
  jcounter :visit

  attr_accessible :user, :title, :content, :catagory_id, :picture, :user_id
  attr_accessor :picture

  validates :user_id, presence: {message: '用户id不能为空' }
  validates :title, presence: { message: '题目不能为空' }#, :length=>{ :minimum=>5, :maximum=>100, :message => '题目长度在6-20之间'  } 
  validates :content, presence: { message: '内容不能为空' }

  before_save :set_preview 

  def self.get_index(user_id, page=1)
    includes(:catagory).select("id, preview, created_at, title, user_id, catagory_id").where("user_id=?", user_id).order("created_at desc").page(page)
  end

  def self.catagory_index(user_id=nil, catagory_id=0, page=1)
    if user_id
      articles = Article.select("id, user_id, catagory_id, preview, created_at, title").where("user_id=? and catagory_id = ?", user_id, catagory_id).order("created_at desc").page(page)
    else
      articles = Article.select("id, user_id, catagory_id, preview, created_at, title").where("catagory_id=?", catagory_id).order("created_at desc").page(page)
    end
    articles
  end
  
  def catagory
    c = super
    unless c
      c = Catagory.default(self.user_id)
    end
    c
  end

  private
  def set_preview
    max_word_count = 800 
    if self.content.length > max_word_count
      self.preview = "#{self.content.first(max_word_count)}..." #为文章内容加入preview
    else
      self.preview = self.content
    end
  end

end
