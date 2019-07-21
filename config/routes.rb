Rails.application.routes.draw do
  root "users#index"
  resources :users do
    resources :missions do
      collection do
        get :desc_endtime
        get :asc_endtime
      end
    end
    resources :tags 
  end
end
