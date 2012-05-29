# encoding: UTF-8
class User < ActiveRecord::Base
  has_many :articles#, :dependent => :destroy 
  has_many :comments
  has_many :user_tagships
  has_many :tags, :through => :user_tagships
  has_many :catagories
  has_one :setting, :dependent => :destroy 
  has_one :picture, :as => :pictureable, :dependent => :destroy  

  scope :check
  attr_accessible :name, :email, :password, :password_confirm, :description, :picture

  validates :name, :presence => { :message => '用户名不能为空' }, :uniqueness => {:message => '用户名已存在' }, :uniqueness => {:case_sensitive=>false, :message => '用户名已存在'}, :length=>{:minimum=>3, :maximum=>15, :message => '用户名长度在3-15之间' }

  validates :email, :presence => {:message => 'Email不能为空'}, :uniqueness => {:message => 'Email已存在' }, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => 'Email格式不正确'}, :uniqueness => {:case_sensitive=>false, :message => 'Email已存在' } 

  validates :password, :presence => {:message => '密码不能为空'}

  validates :description, :length => {:maximum => 200} 

  before_create :encode_pass

  attr_accessor :password_confirm, :remember_me

  def self.check(user)
    @u = User.find_by_name(user[:name])
    if @u
      hashpass = valid_pass(user[:password],@u.salt)
      return @u if hashpass == @u.password
      @u = User.new
      @u.errors.add(:password, '密码错误')
      @u
    else
      @u = User.new
      @u.errors.add(:name, '没有这个用户') 
      @u
    end
  end

  def self.updates(user, id)
    @u = User.find(id)
    if @u
      hashpass = valid_pass(user[:password], @u.salt)
      if hashpass == @u.password
        if user[:password].length >= 6 && user[:password].length <= 20
          user[:password] = Digest::SHA2.new.hexdigest(user[:password_new]+@u.salt)
          @u.update_attributes(user)
          @u.setting.update_attributes(user[:setting])
          @u
        else
          @u.errors.add(:password_new, '新密码长度要在6-20之间')
          @u
        end
      else
        @u.errors.add(:password, '旧密码错误')
        @u
      end
    else
      @u = User.new
      @u.errors.add(:name, '没有这个用户')
      @u
    end
  end
  
  def self.updates_nopass(user, id)
    user.reject! {|k,v| !(k.to_s.index("password").nil?)} 
    @user = User.where('id=?',id).includes(:setting)[0]
    if user[:picture]
      @user.errors.add(:picture, "保存图片失败") unless Picture.create(file:user[:picture], pictureable:@user)
      user.delete [:picture]
    end
    @user.update_attributes(user)
    @user.setting.update_attributes(user[:setting]) if user[:setting]
    @user
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
