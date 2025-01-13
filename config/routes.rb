Rails.application.routes.draw do
  # Welcome page
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
  sessions: 'users/sessions',
  passwords: 'users/passwords',
  confirmations: 'users/confirmations',
  registrations: 'users/registrations',
  }

  root to: "creator_dashboards#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # EXAMINATIONS CONTROLLER
  resources :examinations

  # CREATOR_DASHBOARDS
  resources :creator_dashboards, only: [ :index ] do
    collection do
      get :suppliers
      get :receipts
      get :materials
      get :tests
      # get :new_record
    end
  end

  # BRANDS CONTROLLER
  resources :brands, only: [ :index ] do
    collection do
      post :create_brand
      post :find_brand
      get :new_record
    end
  end

  # BRAND_RECEIPTS CONTROLLER
  resources :brand_receipts, only: [ :index, :create ] do
    collection do
      post :find
      get :new_record
    end
  end

  get '*path', to: redirect('/creator_dashboards')
end
