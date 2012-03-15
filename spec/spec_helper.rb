require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}


  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
#      DatabaseCleaner.clean_with(:truncation)
    end

#    config.before(:each) do
#      DatabaseCleaner.start
#    end

    config.after(:all) do
      DatabaseCleaner.clean
    end

  end

end

Spork.each_run do
  # This code will be run each time you run your specs.

end




