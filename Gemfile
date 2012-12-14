source 'http://ruby.taobao.org'

gem 'rails', '3.2.8'
gem 'railties'

gem 'capistrano', require: false
gem 'capistrano-ext', require: false
gem 'rvm-capistrano', require: false

#数据
gem 'mysql2'
gem 'redis-objects'

#禁用asset日志
gem 'quiet_assets', :git => 'git://github.com/AgilionApps/quiet_assets.git'

#markdown
gem 'redcarpet', '~> 2.2.2'
gem 'pygments.rb'
gem 'rails_autolink'

#表单
gem 'simple_form'

#分页
gem 'kaminari'

#定时任务
gem 'whenever', :require => false 

#社交平台
gem 'omniauth', '~> 1.1.0'
gem 'omniauth-oauth2'
gem 'omniauth-weibo-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-douban', :git => "git://github.com/reducm/omniauth-douban.git" #:git=>"https://github.com/quake/omniauth-douban.git"
gem 'omniauth-twitter', :git => "https://github.com/arunagw/omniauth-twitter.git" 
gem 'omniauth-github'
gem "social-share-button"
#gem 'weibo', :git => "https://github.com/ballantyne/weibo.git" 
gem 'weibo2', :git => "https://github.com/acenqiu/weibo2.git"
gem 'douban-ruby', :git => 'git://github.com/lidaobing/douban-ruby.git'
gem 'twitter'
gem 'koala'

#合并小图片
gem 'sprite-factory'
gem 'chunky_png'

#前端剪切图片
gem 'jcrop-rails', git:'git://github.com/nragaz/jcrop-rails.git'

#小工具
#运行annotate可以把model的属性都打出来
#gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
#gem "rails_best_practices"

#上传
gem 'carrierwave'
gem 'rmagick'
gem 'mime-types'

#ssl
#gem 'rack-ssl-enforcer'

gem 'jquery-rails'
group :assets do
  gem 'sass-rails',   '>= 3.2'
  gem 'turbo-sprockets-rails3'
  gem 'eco'
  gem 'spine-rails'
  gem 'coffee-rails', '>= 3.2'
  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass-rails'
  gem 'font-awesome-sass-rails'
  gem 'bourbon'
end

group :console do
  gem 'awesome_print'
end


gem 'rspec-rails', group:[:test, :development]
group :test do
  gem "factory_girl_rails", "~> 4.0"
  gem "shoulda-matchers"
  #gem 'spork', '~>1.0rc'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'guard-rspec'
  #gem 'libnotify'
  #gem 'rb-inotify'
  gem 'rb-fsevent'
  gem 'database_cleaner'
end

#gem 'growl_notify', group:[:test,:development]
gem 'ruby_gntp', group:[:test,:development]
group :development, :test do
#  gem 'ruby-debug19', :require => 'ruby-debug' 
  gem 'pry-rails'
  gem 'pry-nav'
  gem 'thin'
end
