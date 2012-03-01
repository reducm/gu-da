GuDa::Application.routes.draw do

  root :to => 'index#index'
  match "blog" => 'blog#index'

  scope 'blog' do
    resources :users
    resources :articles
    post "users/login" => 'users#login', :as => :login 
  end
  #match ':controller(/:action(/:id(.:format)))'
end
