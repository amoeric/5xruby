Rails.application.routes.draw do
  root "mission#index"
  resources :mission 
end
