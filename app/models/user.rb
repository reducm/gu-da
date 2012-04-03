# encoding: UTF-8
class User < ActiveRecord::Base
  has_many :articles
  has_many :replies
  has_many :user_tagships
  has_many :tags, :through => :user_tagships
  has_many :catagories
  
  scope :check
  attr_accessible :name, :email, :password, :password_confirm, :head, :birthday, :description, :habbit
  validates_uniqueness_of :name, :email

  validates :name, :presence => { :message => '用户名不能为空' }, :uniqueness => {:message => '用户名已存在' } 
  validates :email, :presence => {:message => 'Email不能为空'}, :uniqueness => {:message => 'Email已存在' },
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :message => 'Email格式不正确' }
  validates :password, :presence => {:message => '密码不能为空'}#, :length=>{:minimum=>6, :maximum=>20, :message => '密码长度在6-20之间'  } 

  before_create :encode_pass

  attr_accessor :password_confirm

  def self.check(user)
    @u = User.find_by_name(user[:name])
    if @u
      hashpass = valid_pass(user[:password],@u.salt)
      return @u if hashpass = @u.password
      User.new.errors.add(:password, '密码错误')
    else
      return User.new.errors.add(:name, '没有这个用户') 
    end
  end

  private
  def getSalt
    Random.rand(10000..100000)
  end

  def encode_pass
    salt = getSalt.to_s
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
