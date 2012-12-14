load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin)  }
#load 'config/deploy' # remove this line to skip loading any of the default tasks

#role :libs, "www.gu-da.com"
#set :user, "root"
task :test_cap do
  run 'ls -l'
end
