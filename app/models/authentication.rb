#encoding: utf-8
class Authentication < ActiveRecord::Base
  attr_accessible :asecret, :atoken, :image, :nickname, :uid, :user_id, :provider, :expires #新浪微博有expires_at
  belongs_to :user
  validates_presence_of :user_id,:atoken, :provider #豆瓣是没有uid的,新浪2.0没有了asecret
  validates_uniqueness_of :provider, :scope => [:user_id], :message => '同一用户下不能绑定多个社交帐号'

  def self.create_from_request(user_id, request)
    atoken = request.credentials.token
    asecret = request.credentials.secret
    expires = request.credentials.expires_at
    info = request.info
    uid = request.uid
    image = info.image
    nickname = info.nickname
    provider = request.provider
    create(user_id:user_id, uid:uid, provider:provider, image:image, nickname:nickname, atoken:atoken, asecret:asecret, expires:expires)
  end

  def update_from_request(request)
    atoken = request.credentials.token
    asecret = request.credentials.secret
    expires = request.credentials.expires_at
    info = request.info
    attributes = {
      atoken:atoken,
      asecret:asecret,
      expires:expires,
      uid:request.uid,
      image:info.image,
      nickname:info.nickname
    }
    self.update_attributes(attributes)
  end

  def self.get_all(user_id)
    as = select([:expires,:provider,:image,:uid,:id,:nickname,:updated_at]).find_all_by_user_id(user_id)
  end

  def self.get_key(user_id)
    as = select([:provider,:uid,:id,:atoken, :asecret,:expires]).find_all_by_user_id(user_id)
  end

  def self.get_weibo(user_id)
    a = select([:provider,:uid,:id,:atoken, :asecret,:expires]).where("user_id=? and provider='weibo'", user_id)[0]
  end
  private
end
