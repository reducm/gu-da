#encoding: utf-8
class Authentication < ActiveRecord::Base
  attr_accessible :asecret, :atoken, :image, :nickname, :uid, :user_id, :provider
  belongs_to :user
  validates_presence_of :user_id,:asecret, :atoken, :provider #豆瓣是没有uid的
  validates_uniqueness_of :provider, :scope => [:user_id], :message => '同一用户下不能绑定多个社交帐号'

  def self.create_from_request(user_id, request)
    atoken = request.credentials.token
    asecret = request.credentials.secret
    info = request.info
    uid = request.uid
    image = info.image
    nickname = info.nickname
    provider = request.provider
    create(user_id:user_id, uid:uid, provider:provider, image:image, nickname:nickname, atoken:atoken, asecret:asecret)
  end

  def self.get_all(user_id)
    as = select([:provider,:image,:uid,:id,:nickname]).find_all_by_user_id(user_id)
  end

  def self.get_key(user_id)
    as = select([:provider,:uid,:id,:atoken, :asecret]).find_all_by_user_id(user_id)
  end
  
  private
end
