class User < ActiveRecord::Base
  validates_presence_of :name, :email
  
  scope :check, lambda{|user| where("name=? and password=?", user[:name], user[:password]) }
end
