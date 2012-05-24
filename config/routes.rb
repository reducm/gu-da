GuDa::Application.routes.draw do

  root :to => 'blog#index'
  match "blog" => 'blog#index'
  match "/auth/:provider/callback", :to => "sessions#create"

  scope 'blog' do
    resources :users do
      resources :articles
      collection do 
        post :login
      end
    end
    resources :articles
    resources :catagories
    resources :tags
    resources :comments
    post "users/login" => 'users#login', :as => :login 
  end
  match ':controller(/:action(/:id(.:format)))'  
end
