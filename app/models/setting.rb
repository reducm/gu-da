class Setting < ActiveRecord::Base
  belongs_to :user
  has_one :picture, as: :pictureable, dependent: :destroy
  validates :user_id, presence: true, uniqueness: true

  attr_accessible :picture
end
