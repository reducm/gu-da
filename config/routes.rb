GuDa::Application.routes.draw do
  root :to => 'index#index'
  
  namespace :blog do
      
  end
  match ':controller(/:action(/:id(.:format)))'
end
