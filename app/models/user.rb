class User < ActiveRecord::Base
  has_many :articles
  validates_presence_of :name

  protected
  def self.check(user)
    where("name=? and password=?", user[:name], user[:password])[0]
  end
end
