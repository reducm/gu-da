require 'jas/jconfig'
module Douban
  FILE = "#{Rails.root}/config/douban.yml"
  include Jconfig
end

module Weibo
  FILE = "#{Rails.root}/config/weibo.yml"
  include Jconfig
end

module Twitter
  FILE = "#{Rails.root}/config/twitter.yml"
  include Jconfig
  self.configure do |c|
    c.consumer_key = self.jconfig.api_key
    c.consumer_secret = self.jconfig.api_secret
  end
end

module Facebook
  FILE = "#{Rails.root}/config/facebook.yml"
  include Jconfig
end

module Weibo2
  Weibo2::Config.api_key = Weibo.jconfig.api_key.to_s
  Weibo2::Config.api_secret = Weibo.jconfig.api_secret
  Weibo2::Config.redirect_uri = Weibo.jconfig.redirect_uri
end

module Admin
  FILE = "#{Rails.root}/config/admin.yml"
  include Jconfig
end 
