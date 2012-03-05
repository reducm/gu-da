class User < ActiveRecord::Base
  has_many :articles
  has_many :tags
  has_many :catagories

  attr_accessible :name, :email, :password, :head, :birthday, :description, :habbit
  validates_presence_of :name, :password

  protected
  def self.check(user)
    where("name=? and password=?", user[:name], user[:password])[0]
  end
end
