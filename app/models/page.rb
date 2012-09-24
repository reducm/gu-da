#encoding: UTF-8
class Page < ActiveRecord::Base
  has_many :pictures, :as => :pictureable, :dependent => :destroy  
  attr_accessible :content, :title, :user_id
  validates :title, :uniqueness => {message: '题目不能重复'}, :presence => true 

  def self.get_index
    ps = includes(:pictures).all
    pages = {}
    ps.each do|p|
      pages[p.title] = p
    end
    pages
  end

  def self.find_or_create(params)
    page = Page.find_by_title(params[:title]) || Page.create(title:params[:title])
    page
  end
end
