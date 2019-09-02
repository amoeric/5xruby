Rails.application.routes.draw do
  root "sessions#new"
  resource :user, except: [:index, :destroy]
  resources :tags, except: [:show, :edit, :update]
  resources :missions do
    resources :tags, except: [:index, :show, :edit, :update]
  end
  

  namespace :admin, path: "amoeric" do
    root 'pages#index'
    resources :missions 
    resources :users do
      resources :missions 
      resources :tags 
    end
  end

  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get    '/404', to: 'errors#not_found'
  get    '/500', to: 'errors#internal_server_error'
end
