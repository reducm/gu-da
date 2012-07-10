require 'jas/jconfig'
module Douban
  FILE = "#{Rails.root}/config/douban.yml"
  include Jconfig
  binding.pry
end

module Weibo2
  FILE = "#{Rails.root}/config/weibo.yml"
  include Jconfig
end
