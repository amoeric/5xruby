Rails.application.routes.draw do
  root "sessions#new"
  resources :users do
    resources :tags, except: [:show, :edit, :update]
    resources :missions do
      resources :tags, except: [:index, :show, :edit, :update]
    end
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
end
