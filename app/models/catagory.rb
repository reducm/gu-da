class Catagory < ActiveRecord::Base
  has_many :articles
  belongs_to :user

  validates_presence_of :user_id, :name
end
