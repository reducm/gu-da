class Tag < ActiveRecord::Base
  has_many :article_tagships
  has_many :articles, :through => :article_tagships
  belongs_to :user
  validates_uniqueness_of :name
end
