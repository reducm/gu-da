module Douban
  module Config
    def self.api_key
      @@api_key
    end

    def self.api_secret
      @@api_secret
    end

    def self.api_key=(val)
      @@api_key=val
    end

    def self.api_secret=(val)
      @@api_secret=val
    end

    if File.exist?("#{Rails.root}/config/douban.yml")
      config = YAML.load_file("#{Rails.root}/config/douban.yml")[Rails.env||'develoment']
      self.api_key=config['api_key']
      self.api_secret=config['api_secret']
    end
  end
end

module Weibo2
  module Config
    def self.api_key
      @@api_key
    end

    def self.api_secret
      @@api_secret
    end

    def self.api_key=(val)
      @@api_key=val
    end

    def self.api_secret=(val)
      @@api_secret=val
    end

    if File.exist?("#{Rails.root}/config/weibo.yml")
      config = YAML.load_file("#{Rails.root}/config/weibo.yml")[Rails.env||'develoment']
      self.api_key=config['api_key']
      self.api_secret=config['api_secret']
      self.redirect_uri = 'http://www.gu-da.com'
    end
  end
end
