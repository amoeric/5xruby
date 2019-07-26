Rails.application.routes.draw do
  root "users#index"
  resources :users do
    resources :missions 
    resources :tags 
  end
end
