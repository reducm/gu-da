class Catagory < ActiveRecord::Base
  has_many :atricles
  belongs_to :user

  validates_presence_of :user_id, :name
end
