# encoding: UTF-8
class User < ActiveRecord::Base
    has_many :articles
    has_many :replies
    has_many :user_tagships
    has_many :tags, :through => :user_tagships
    has_many :catagories

    attr_accessible :name, :email, :password, :password_confirm, :head, :birthday, :description, :habbit
#    validates_presence_of :name, :password, :email
    validates_uniqueness_of :name, :email

    validates :name, :presence => {:message => '用户名不能为空'}, :uniqueness => {:message => '用户名已存在' } 
    validates :email, :presence => {:message => 'Email不能为空'}, :uniqueness => {:message => 'Email已存在' },
                      :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :message => 'Email格式不正确' }
    validates :password, :presence => {:message => '密码不能为空'} 
    attr_accessor :password_confirm
    protected
    def self.check(user)
        where("name=? and password=?", user[:name], user[:password])[0]
    end
end
