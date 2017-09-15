UniversalAr::Engine.routes.draw do
  root to: 'roles#index'
  
  resource :setup, controller: :setup
  
  resources :tags
  resources :comments
  resources :attachments
  resources :pictures
  resources :configs
  resources :statuses
  resources :configurations
  
  resources :users do
    collection do
      get :autocomplete
    end
  end
  
  resources :roles do
    member do
      get :users
      post :add_user, :invite_user
      delete :remove_user
    end
  end
end