# encoding: UTF-8
module Jconfig
  def self.included(receiver)
    receiver.send :include, Config
    self
  end

  module Config
    def self.api_key
      @@api_key
    end

    def self.set_file

    def self.api_secret
      @@api_secret
    end

    def self.api_key=(val)
      @@api_key=val
    end

    def self.api_secret=(val)
      @@api_secret=val
    end

    if File.exist?(FILE)
      config = YAML.load_file(FILE)[Rails.env||'develoment']
      self.api_key=config['api_key']
      self.api_secret=config['api_secret']
      self.redirect_uri = 'http://www.gu-da.com'
    end
  end
end
