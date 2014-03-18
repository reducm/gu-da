# coding: utf-8
require "rvm/capistrano"
require "bundler/capistrano"
#require "sidekiq/capistrano"
set :rvm_type, :system

system "ssh-add"
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

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
server 'www.gu-da.com', :app, :web, :db, :primary => true

namespace :deploy do
  task :assets do
    run "cd #{deploy_to}/current; time rake assets:resprite --trace; time rake assets:clean --trace; time rake assets:precompile --trace"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{deploy_to}/current/tmp/restart.txt"
  end

  task :copy_config do
    run "cp #{deploy_to}/shared/config/*.yml #{release_path}/config"
  end
end
after "deploy:finalize_update","deploy:symlink", "deploy:copy_config", "deploy:migrate", "deploy:assets", "deploy:restart"
