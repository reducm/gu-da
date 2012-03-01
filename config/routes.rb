GuDa::Application.routes.draw do

  root :to => 'index#index'
  match "blog" => 'blog#index'

  scope 'blog' do
    resources :users
<<<<<<< HEAD
    resources :articles
=======
    post "users/login" => 'users#login', :as => :login 
>>>>>>> 8d7f068c135b4bce102796ecfa97fffc441cebfb
  end
  #match ':controller(/:action(/:id(.:format)))'
end
