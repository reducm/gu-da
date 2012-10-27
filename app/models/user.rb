# encoding: UTF-8
class User < ActiveRecord::Base
  has_many :articles#, :dependent => :destroy 
  has_many :comments
  has_many :user_tagships
  has_many :tags, through: :user_tagships
  has_many :catagories
  has_one :setting, dependent: :destroy 
  has_one :picture, as: :pictureable, dependent: :destroy  
  has_many :notifications, as: :senderable
  has_many :authentications

  scope :check
  attr_accessible :nickname, :email, :password, :password_confirm, :description, :picture, :setting

  validates :nickname, presence: { message: '昵称不能为空' }, uniqueness: {message: '昵称已存在' }, uniqueness: {case_sensitive:false, message: '昵称已存在'}, length:{minimum:3, maximum:15, message: '用户名长度在3-15之间' }, exclusion: {in: %w(users articles authentications blog catagories comments tags errors index notifications sessions tags auth callback admin admins pages DemoUser picture pictures), message: "该昵称不合法,请使用其他昵称" } 

  validates :email, presence: {message: 'Email不能为空'}, uniqueness: {message: 'Email已存在' }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: 'Email格式不正确'}
  validates :password, presence: {message: '密码不能为空'}

  validates :description, length: {maximum: 200} 

  before_create :encode_pass

  attr_accessor :password_confirm, :remember_me

  def name
    self.nickname
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

  def self.updates(user, id)
    @user = User.find(id)
    if @user
      hashpass = valid_pass(user[:password], @user.salt)
      if hashpass == @user.password
        if user[:password].length >= 6 && user[:password].length <= 20
          user[:password] = Digest::SHA2.new.hexdigest(user[:password_new]+@user.salt)
          User.transaction do
            @user.update_picture(user)
            @user.update_setting(user)
            @user.update_attributes(user) if user.size > 0
          end
          @user
        else
          @user.errors.add(:password_new, '新密码长度要在6-20之间')
          @user
        end
      else
        @user.errors.add(:password, '旧密码错误')
        @user
      end
    else
      @user = User.new
      @user.errors.add(:nickname, '没有这个用户')
      @user
    end
  end

  def self.updates_nopass(user, id)
    user.reject! {|k,v| !(k.to_s.index("password").nil?)} 
    @user = User.where('id=?',id).includes(:setting)[0]
    User.transaction do
      @user.update_picture(user)
      @user.update_setting(user)
      @user.update_attributes(user) if user.size > 0
    end
    @user
  end

  def self.get_user(params)
      params[:user_id].class==Fixnum || (params[:user_id] =~ /^\d+$/) ? where("id=?",params[:user_id]).includes(:setting)[0] : where("nickname=?",params[:user_id]).includes(:setting)[0]
  end

  def self.by_id(id)
    includes(:setting).where("id=?",id)[0] 
  end

  def update_picture(params)
    if params[:picture]
      picture = self.picture || Picture.new
      picture.update_attributes(pictureable:self, file:params[:picture])
      params.delete :picture #mass
    end
  end

  def update_setting(params)
    if params[:setting]
      self.setting.update_attributes(params[:setting]) 
      params.delete :setting
    end
  end

  private
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

  def self.validte_passlength
    if self.password.length < 6 and self.password.length > 20
      errors.add(:password, '密码长度在6-20之间')
      false
    end
  end
end
