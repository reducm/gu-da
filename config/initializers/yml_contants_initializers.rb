require 'jas/jconfig'
module Douban
  FILE = "#{Rails.root}/config/douban.yml"
  include Jconfig
end

module Weibo
  FILE = "#{Rails.root}/config/weibo.yml"
  include Jconfig
end

module Weibo2
  Weibo2::Config.api_key = Weibo::Config.api_key
  Weibo2::Config.api_secret = Weibo::Config.api_secret
  Weibo2::Config.redirect_uri = Weibo::Config.redirect_uri
end
