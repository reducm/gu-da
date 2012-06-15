GuDa::Application.routes.draw do
  root :to => 'blog#index'
  match "blog" => 'blog#index'
  match "/auth/:provider/callback", :to => "sessions#create"

  #scope 'blog' do
  resources :users do
    resources :articles
    collection do 
      post :login
    end
    resources :notifications, :only => [:index, :show, :destroy] 
    resources :settings
  end

  resources :articles
  resources :catagories
  resources :tags
  resources :comments
  post "users/login" => 'users#login', :as => :login 

#  end
  match ':user_name', :to => 'articles#index', :as => :name
  match ':controller(/:action(/:id(.:format)))'  
end
