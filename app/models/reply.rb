class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  validates_presence_of :content, :user_id, :article_id
end
