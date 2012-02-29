class User < ActiveRecord::Base
  scope :check, lambda{|user| where("name=? and password=?", user[:name], user[:password]) }
end
