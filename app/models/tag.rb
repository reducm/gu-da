class Tag < ActiveRecord::Base
  has_many :article_tagships
  has_many :articles, :through => :article_tagships
  has_many :user_tagships
  has_many :user, :through => :user_tagships 
  validates_uniqueness_of :name
end
