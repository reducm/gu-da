require 'jas/jconfig'
module Douban
  FILE = "#{Rails.root}/config/douban.yml"
  include Jconfig
  set_config(FILE)
end

module Weibo
  FILE = "#{Rails.root}/config/weibo.yml"
  include Jconfig
  set_config(FILE)
end

module Twitter
  FILE = "#{Rails.root}/config/twitter.yml"
  include Jconfig
  self::Config.set_config(FILE)
end

module Facebook
  FILE = "#{Rails.root}/config/facebook.yml"
  include Jconfig
  set_config(FILE)
end


module Weibo2
  Weibo2::Config.api_key = Weibo::Config.api_key
  Weibo2::Config.api_secret = Weibo::Config.api_secret
  Weibo2::Config.redirect_uri = Weibo::Config.redirect_uri
end

module Admin
  FILE = "#{Rails.root}/config/admin.yml"
  include Jconfig
  set_config(FILE)
end 
