GuDa::Application.routes.draw do
  root :to => 'blog#index'
  match "blog" => 'blog#index'
  match "/auth/:provider/callback", :to => "authentications#create", :as => :auth

  #scope 'blog' do
  resources :users do
    resources :articles
    collection do 
      post :login
    end
    resources :notifications, :only => [:index, :show, :destroy] 
    resources :settings
    resources :authentications
  end

  resources :articles
  resources :catagories
  resources :tags
  resources :comments
  resources :notifications
  post "users/login" => 'users#login', :as => :login 

#  end
  match ':user_name', :to => 'articles#index', :as => :name
  match ':controller(/:action(/:id(.:format)))'  
end
