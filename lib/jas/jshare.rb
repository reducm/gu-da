# encoding: UTF-8
require 'douban'
module JShare
  private
  def share_to(article, providers)
    jshare_article(article,providers)
  end

  def jshare_article(article, providers, options={}) 
    as = Authentication.spec_provider(article.user_id,providers)
    options['url'] ||= user_article_url(article.user_id, article)
    if as.size > 0
      as.each do |a|
        args = {'title'=> article.title, 'content'=>article.content}.merge(options).merge(a.attributes)
        begin
          send(a.provider.to_sym, args)
        rescue Exception
          Rails.logger.error $!.message
          raise "出错啦！！！ #{$!.message}"
        ensure
          next
        end
      end
    else
      false
    end
  end

  def weibo(options)
    client = Weibo2::Client.from_hash({access_token:options['atoken'],expires_in:options['expires'].to_i})
    content = "发表了博客：#{options['title']}, \"#{options['content'].first(50)}...\" #{options['url']}"
    #client.refresh! 这个要申请了refresh_key才能用
    r = client.statuses.update(content)
    r.parsed
  end

  def douban(options)
    douban = Douban::Authorize.new(Douban.jconfig.api_key, Douban.jconfig.api_secret)
    douban.access_token = {token:options['atoken'], secret:options['asecret']}
    douban.create_note(options['title'], "#{options['content']}\n来自:#{options['url']}")
  end

  def facebook(options)
    @graph = Koala::Facebook::API.new(options["atoken"])
    @graph.put_wall_post(content = "发表了博客：#{options['title']} #{options['url']}")  
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
