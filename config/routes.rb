Rails.application.routes.draw do
  root "cryptocurrencies#index"

  # Ruta para verificar el estado de la app
  get "up" => "rails/health#show", as: :rails_health_check

  resources :cryptocurrencies, only: [:index, :create, :show, :update] do
    collection do
      get :low_to_high
      get :high_to_low
      get :search

      # NUEVA RUTA: sincroniza datos desde la API de CoinGecko
      post :sync_from_api
    end

    member do
      # NUEVA RUTA: alterna el estado de favorito (true/false)
      patch :toggle_favorite
    end
  end

  # Rutas PWA comentadas
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # root "posts#index"
end
