#encoding: utf-8
class Authentication < ActiveRecord::Base
  #attr_accessible :asecret, :atoken, :image, :nickname, :uid, :user_id, :provider, :location,:expires,:temp #新浪微博有expires_at
  belongs_to :user
  validates_presence_of :atoken, :provider #豆瓣是没有uid的,新浪2.0没有了asecret
  validates_uniqueness_of :provider, scope: [:user_id], message: '同一用户下不能绑定多个社交帐号'
  validates :user_id, presence: {:message => '非临时验证,user_id不能为空'}
  
  #TODO :authentication model 在authen_controller bind和users_create里头需要检验一下合法性
  def self.create_from_request(user_id = 0, request)
    atoken = request.credentials.token
    asecret = request.credentials.secret
    expires = request.credentials.expires_at
    info = request.info
    uid = request.uid
    image = info.image
    nickname = info.nickname
    provider = request.provider
    create(user_id:user_id, uid:uid, provider:provider, image:image, nickname:nickname, atoken:atoken, asecret:asecret, expires:expires, location:info.location)
  end

  def self.create_temp_from_request(request)
    self.create_from_request(0, request) 
  end

  def self.find_or_create(user_id, request)
    a = Authentication.find_by_uid_and_provider(request.uid, request.provider) 
    if a
      a.update_from_request(request)
    else
      a = Authentication.create_from_request(user_id,request)
    end
    a
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
      nickname:info.nickname,
      location:info.location
    }
    self.update_attributes(attributes)
  end

  def expires?
    return false if self.provider == "douban" || self.provider == "twitter"
    if self.provider == "facebook" || self.provider == "weibo"
      return true if (self.expires.to_i-Time.now.to_i) <= 0
    end
    return false
  end

  def temp?
    return self.temp
  end

  def self.get_all(user_id)
    as = select([:expires,:provider,:image,:uid,:id,:nickname,:updated_at]).find_all_by_user_id(user_id)
  end

  def self.get_key(user_id)
    as = select([:provider,:uid,:id,:atoken, :asecret,:expires]).find_all_by_user_id(user_id)
  end

  def self.spec_provider(user_id,providers=[])
    as = select([:provider,:uid,:id,:atoken, :asecret,:expires]).where("user_id = ? and provider in (?)",user_id, providers)
  end

  def self.get_weibo(user_id)
    a = select([:provider, :uid, :id, :atoken, :asecret, :expires]).where("user_id=? and provider='weibo'", user_id)[0]
  end
  private
end
