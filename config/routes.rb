Rails.application.routes.draw do
  root "users#index"
  resources :users do
    resources :missions do
      collection do
        get :desc_endtime
        get :asc_endtime
      end
      collection do
        get :search
      end
    end
    resources :tags 
  end
end
