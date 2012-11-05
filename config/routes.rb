GuDa::Application.routes.draw do
  root :to => 'blog#index'
  match "blog" => 'blog#index'
  match "/auth/:provider/callback", :to => "authentications#create"
  match "/auth/failure", :to => "authentications#index"
  match "/articles/demonew", :to => "articles#demonew"
  match "/articles/demoshow", :to => "articles#demoshow"
  post "/pages/", :to => "pages#update"
  put "/pages/", :to => "pages#update"

  #scope 'blog' do
  resources :users do
    resources :articles
    collection do 
      post :login
    end
    resources :notifications, :only => [:index, :show, :destroy] 
    resources :settings
    resources :authentications
    resources :catagories
    resources :pictures
  end
 
  resources :pictures, :only => [:create, :destroy]
  resources :admins
  resources :articles
  resources :catagories
  resources :tags
  resources :comments
  resources :notifications
  resources :authentications do
    collection do
      post :share
    end
  end
  post "users/login" => 'users#login', :as => :login 

#  end
  match ':user_id', :to => 'articles#index', :as => :name
  match ':controller(/:action(/:id(.:format)))'  
end
