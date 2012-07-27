# encoding: UTF-8
module Jconfig
  def self.included(receiver)
    receiver.instance_eval do
      class << self
        attr_accessor :jconfig
      end 
      self.jconfig = Jconfig.create_module(self::FILE)
    end
  end

  def self.create_module(f)
    Module.new do
      if File.exist?(f)
        config = YAML.load_file(f)[Rails.env||'develoment'] 
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
