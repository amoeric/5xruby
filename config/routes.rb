Rails.application.routes.draw do
  root "user#index"
  resources :user do
    resources :mission 
  end
end
