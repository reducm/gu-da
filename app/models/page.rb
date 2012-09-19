#encoding: UTF-8
class Page < ActiveRecord::Base
  has_many :picture, :as => :pictureable, :dependent => :destroy  
  attr_accessible :content, :title, :user_id
  validates :title, :uniqueness => {message: '题目不能重复'}, :presence => true 

  def self.get_index
    ps = select([:title,:content]).includes(:picture).all
    pages = {}
    ps.each do|p|
      pages[p.title] = p
    end
    pages
  end
end
