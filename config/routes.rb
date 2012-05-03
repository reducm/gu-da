GuDa::Application.routes.draw do

  root :to => 'index#index'
  match "blog" => 'blog#index'

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
    post "users/login" => 'users#login', :as => :login 
  end
  match ':controller(/:action(/:id(.:format)))'  
end
