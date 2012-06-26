# encoding: UTF-8
require 'douban'
module JShare
  private
  def jshare(user_id, title,content,options={})
    as = Authentication.get_key(user_id)
    if as.size > 0
      as.each do |a|
        args = {'title'=> title, 'content'=>content}.merge(options).merge(a.attributes)
        send a.provider.to_sym, args
      end
    end
  end

  def weibo(options)
    oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
    oauth.authorize_from_access(options['atoken'], options['asecret'])
    content = "发表了博客：#{options['title']}, \"#{options['content'].first(50)}...\" #{options['url']}"
    Weibo::Base.new(oauth).update(content)
  end

  def douban(options)
    
    douban = Douban::Authorize.new(Douban::Config.api_key, Douban::Config.api_secret)
    douban.access_token = {token:options['atoken'], secret:options['asecret']}
    douban.create_note(options['title'], options['content'])
  end

  def facebook(options)
  end

  def twitter(options)
  end
end
