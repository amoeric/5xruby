Rails.application.routes.draw do
  root "users#index"
  resources :users do
    resources :missions 
  end
  resources :tags 
end
