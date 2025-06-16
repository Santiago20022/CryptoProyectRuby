Rails.application.routes.draw do
  root "cryptocurrencies#index"

  # Ruta para verificar el estado de la app
  get "up" => "rails/health#show", as: :rails_health_check

  resources :cryptocurrencies, only: [:index, :create, :show, :update] do
    collection do
      get :low_to_high
      get :high_to_low
      get :search
    end
    member do
      patch :toggle_favorite
    end
  end
end
