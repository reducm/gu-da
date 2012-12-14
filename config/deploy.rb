# coding: utf-8
require "rvm/capistrano"
require "bundler/capistrano"
#require "sidekiq/capistrano"
set :rvm_type, :system

set :application, "gu-da"
set :repository,  "git://github.com/reducm/gu-da.git"
set :branch, "master"
set :scm, :git
set :user, "root"
set :deploy_to, "/root/#{application}"
set :runner, "ruby"
set :deploy_via, :remote_cache
set :deploy_env, "production"
set :rails_env, "production"
# set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :use_sudo, false
set :shared_children, shared_children + %w{public/uploads}
role :web, "106.187.37.46"                          # Your HTTP server, Apache/etc
role :app, "106.187.37.46"                          # This may be the same as your `Web` server
role :db,  "106.187.37.46", :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :assets do
    run "cd #{deploy_to}/current; time rake assets:clean --trace; time rake assets:precompile --trace"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  task :copy_config do
    run "cp #{deploy_to}/shared/config/*.yml #{release_path}/config"
  end
end

after "deploy:update_code", "deploy:copy_config", "deploy:migrate", "deploy:assets", "deploy:restart"
