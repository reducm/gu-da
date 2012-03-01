class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :catagory
end
