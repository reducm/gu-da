# encoding: UTF-8
class User < ActiveRecord::Base
  has_many :articles#, :dependent => :destroy 
  has_many :comments
  has_many :user_tagships
  has_many :tags, through: :user_tagships
  has_many :catagories
  has_one :setting, dependent: :destroy 
  has_many :pictures, as: :pictureable, dependent: :destroy  
  has_many :notifications, as: :senderable
  has_many :authentications

  scope :check
  attr_accessible :nickname, :email, :password, :password_confirm, :description, :picture, :setting

  validates :nickname, presence: { message: '昵称不能为空' }, uniqueness: {message: '昵称已存在' }, uniqueness: {case_sensitive:false, message: '昵称已存在'}, length:{minimum:3, maximum:15, message: '用户名长度在3-15之间' }, exclusion: {in: %w(users articles authentications blog catagories comments tags errors index notifications sessions tags auth callback admin admins pages assets vendor public DemoUser picture pictures uploads drafts), message: "该昵称不合法,请使用其他昵称" }

  validates :email, presence: {message: 'Email不能为空'}, uniqueness: {message: 'Email已存在' }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: 'Email格式不正确'}
  validates :password, presence: {message: '密码不能为空'}

  validates :description, length: {maximum: 200} 

  before_create :encode_pass
  after_create :create_setting

  attr_accessor :password_confirm, :remember_me

  def name
    self.nickname
  end

  def blog_name
    setting.blog_name || "#{nickname}的博客"
  end

  def head
    self.setting.picture
  end

  def name=(val)
    self.nickname = val
  end

  def self.check(user)
    @u = User.find_by_email(user[:email])
    if @u
      hashpass = valid_pass(user[:password],@u.salt)
      return @u if hashpass == @u.password
      @u = User.new
      @u.errors.add(:password, '密码错误')
      @u
    else
      @u = User.new
      @u.errors.add(:email, '没有这个用户') 
      @u
    end
  end

  def self.updates(params, id)
    params.delete :email
    return updates_nopass(params,id) if params[:password].blank?
    @user = User.find(id)
    return @user if (error_password_params(params, @user).errors.any?)
    hashpass = valid_pass(params[:password], @user.salt)
    if hashpass != @user.password
      @user.errors.add(:password, '旧密码错误') 
      return @user
    end
    params[:password] = Digest::SHA2.new.hexdigest(params[:password_new]+@user.salt)
    User.transaction do
      @user.update_setting(params)
      @user.update_attributes(params) if params.size > 0
    end
    @user
  end

  def self.updates_nopass(user, id)
    user.reject! {|k,v| !(k.to_s.index("password").nil?)} 
    @user = User.where('id=?',id).includes(:setting)[0]
    User.transaction do
      @user.update_setting(user)
      @user.update_attributes(user) if user.size > 0
    end
    @user
  end

  def self.get_user(params)
    params[:user_id] = params[:id] if params[:id]
    params[:user_id].class==Fixnum || (params[:user_id] =~ /^\d+$/) ? where("id=?",params[:user_id]).includes(:setting)[0] : where("nickname=?",params[:user_id]).includes(:setting)[0]
  end

  def self.by_id(id)
    includes(setting:[:picture]).where("id=?",id)[0] 
  end

  def update_setting(params) 
    return unless params[:setting]
    if params[:setting][:picture]
      picture = self.setting.picture || Picture.new
      picture.update_attributes(pictureable: self.setting, file: params[:setting][:picture])
      params[:setting].delete :picture
    end

    self.setting.update_attributes(params[:setting]) 
    params.delete :setting
  end

  private
  def create_setting
    Setting.create(user:self)
  end

  def getSalt
    Random.rand(10000..100000).to_s
  end

  def encode_pass
    salt = getSalt
    self.password = Digest::SHA2.new.hexdigest(self.password+salt)
    self.salt = salt
  end

  def self.valid_pass(pass, salt)
    Digest::SHA2.new.hexdigest(pass+salt)
  end

  def self.error_password_params(params, user)
    user.errors.add(:password_new,'两次输入密码不同') if params[:password_new] != params[:password_confirm]
    user.errors.add(:password_new, '新密码长度要在6-20之间') unless (params[:password_new].length >= 6) && (params[:password_new].length <= 20)
    user
  end

  def self.validte_passlength
    if self.password.length < 6 and self.password.length > 20
      errors.add(:password, '密码长度在6-20之间')
      false
    end
  end
end
