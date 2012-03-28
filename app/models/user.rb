# encodin: UTF-8
class User < ActiveRecord::Base
    has_many :articles
    has_many :replies
    has_many :user_tagships
    has_many :tags, :through => :user_tagships
    has_many :catagories

    attr_accessible :name, :email, :password, :password_confirm, :head, :birthday, :description, :habbit
    validates_uniqueness_of :name, :email

    validates :name, :presence => {:message => '用户名不能为空'}, :uniqueness => {:message => '用户名已存在' } 
    validates :email, :presence => {:message => 'Email不能为空'}, :uniqueness => {:message => 'Email已存在' },
                      :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :message => 'Email格式不正确' }
    validates :password, :presence => {:message => '密码不能为空'} 
    before_create :confirm_pass

    attr_accessor :password_confirm

    private
    def self.check(user)
        where("name=? and password=?", user[:name], user[:password])[0]
    end

    def confirm_pass
        if self.password != self.password_confirm
          errors[:password_confirm] = '前后密码输入不一致' 
          return false;
        end
    end
end
