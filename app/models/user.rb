class User < ActiveRecord::Base
  has_many :articles
  has_many :replies
  has_many :user_tagships
  has_many :tags, :through => :user_tagships
  has_many :catagories

  attr_accessible :name, :email, :password, :head, :birthday, :description, :habbit
  validates_presence_of :name, :password, :email
  validates_uniqueness_of :name, :email

  protected
  def self.check(user)
    where("name=? and password=?", user[:name], user[:password])[0]
  end
end
