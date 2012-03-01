class User < ActiveRecord::Base
  has_many :articles
  scope :check, lambda{|user| where("name=? and password=?", user[:name], user[:password]) }
end
