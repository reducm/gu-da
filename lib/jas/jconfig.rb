# encoding: UTF-8
module Jconfig
  def self.included(receiver)
    receiver.send :include, Jconfig::Config
  end

  module Config
    def set_config(file)
      if File.exist?(file)
        config = YAML.load_file(file)[Rails.env||'develoment'] 
        if config.has_key?('admin')
          class << self
            attr_accessor :admin
          end
          self.admin = config['admin']
        else
          class << self
            attr_accessor :api_key,:api_secret, :redirect_uri
          end
          self.api_key=config['api_key']
          self.api_secret=config['api_secret']
          self.redirect_uri = 'http://www.gu-da.com'
        end
      end
    end
  end
end
