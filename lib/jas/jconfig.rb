# encoding: UTF-8
module Jconfig
  def self.included(receiver)
    receiver.send :include, Jconfig::Config
    receiver::Config.set_config(receiver::FILE)
  end

  module Config
    class << self
      attr_accessor :api_key,:api_secret, :redirect_uri
    end

    def self.set_config(file)
      if File.exist?(file)
        config = YAML.load_file(file)[Rails.env||'develoment']
        self.api_key=config['api_key']
        self.api_secret=config['api_secret']
        self.redirect_uri = 'http://www.gu-da.com'
      end
    end
  end
end
