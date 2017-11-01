Rails.application.routes.draw do
  resources :users, only: [:create, :new, :show, :index]  
  resource :session, only: [:create, :new, :destroy]  
  # resources :bands, only: [:index, :create, :edit, :new, :show, :update]
  resources :bands, only: :show do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy]
end
