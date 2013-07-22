GuDa::Application.routes.draw do
  root :to => 'blog#index'
  get "blog" => 'blog#index'
  get "blog/logout" => "blog#logout", as: :logout
  get "/auth/:provider/callback", :to => "authentications#create"
  get "/auth/failure", :to => "authentications#index"
  get "/articles/demonew", :to => "articles#demonew"
  get "/articles/demoshow", :to => "articles#demoshow"

  #scope 'blog' do
  resources :users do
    resources :articles do
      resources :comments
    end
    resources :drafts
    collection do 
      post :login
      post :new
      get :new
    end
    resources :notifications, :only => [:index, :show, :destroy] 
    resources :settings
    resources :authentications
    resources :catagories
    resources :pictures
  end
 
  resources :pages
  resources :pictures, :only => [:create, :destroy]
  resources :admins
  resources :articles do
    resources :comments
  end
  resources :drafts
  resources :catagories
  resources :tags
  resources :notifications
  resources :authentications do
    collection do
      post :share
    end
  end
  post "users/login" => 'users#login', :as => :login 

#  end
  get ':user_id', :to => 'articles#index', :as => :name
  #match ':controller(/:action(/:id(.:format)))'  
end
