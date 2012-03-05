class Catagory < ActiveRecord::Base
  has_many :atricles
  belongs_to :user
end
