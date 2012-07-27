# encoding: UTF-8
require 'douban'
module JShare
  private
  def jshare(user_id, title,content,options={})
    as = Authentication.get_key(user_id)
    if as.size > 0
      as.each do |a|
        args = {'title'=> title, 'content'=>content}.merge(options).merge(a.attributes)
        begin
          send a.provider.to_sym, args
        rescue Exception
          Rails.logger.error $!.message
          raise "出错啦！！！ #{$!.message}"
        ensure
          next
        end
      end
    end
  end

  def weibo(options)
    client = Weibo2::Client.from_hash({access_token:options['atoken'],expires:options['expires'].to_i})
    content = "发表了博客：#{options['title']}, \"#{options['content'].first(50)}...\" #{options['url']}"
    #client.refresh! 这个要申请了refresh_key才能用
    r = client.statuses.update(content)
    r.parsed
  end

  def douban(options)
    douban = Douban::Authorize.new(Douban.jconfig.api_key, Douban.jconfig.api_secret)
    douban.access_token = {token:options['atoken'], secret:options['asecret']}
    douban.create_note(options['title'], options['content'])
  end

  def facebook(options)
  end

  def twitter(options)
    Twitter.configure do|c|
      c.oauth_token = options['atoken']
      c.oauth_token_secret = options['asecret']
    end
    content = "发表了博客：#{options['title']}, \"#{options['content'].first(50)}...\" #{options['url']}"
    Twitter.update(content)
  end
end
