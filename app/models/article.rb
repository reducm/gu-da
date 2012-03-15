class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :catagory
  has_many :article_tagships
  has_many :tags, :through => :article_tagships 
  has_many :replies

  validates_presence_of :title, :content, :user_id
  
end
