# coding: utf-8
require "bundler/capistrano"
require "sidekiq/capistrano"

require "rvm/capistrano"
#set :rvm_ruby_string, 'ruby-1.9.3-p194-patch'
set :rvm_type, :user

set :application, "gu-da"
set :repository,  "git://github.com/reducm/gu-da.git"
set :branch, "master"
set :scm, :git
set :user, "root"
set :deploy_to, "/root/#{application}"
set :runner, "ruby"
# set :deploy_via, :remote_cache
set :git_shallow_clone, 1

role :web, "106.187.37.46"                          # Your HTTP server, Apache/etc
role :app, "106.187.37.46"                          # This may be the same as your `Web` server
role :db,  "106.187.37.46", :primary => true # This is where Rails migrations will run


namespace :deploy do
  task :start, :roles => :app do
    run "cd #{deploy_to}/current/; RAILS_ENV=production unicorn_rails -c #{unicorn_path} -D"
  end

  task :stop, :roles => :app do
    run "kill -QUIT `cat #{deploy_to}/current/tmp/pids/unicorn.pid`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "kill -USR2 `cat #{deploy_to}/current/tmp/pids/unicorn.pid`"
  end
end

task :compile_assets, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production bundle exec rake assets:precompile"
end

task :mongoid_migrate_database, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production bundle exec rake db:migrate"
end

after "deploy:finalize_update","deploy:symlink",  :compile_assets
