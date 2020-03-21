Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :create, :update, :destroy]
      # , :show
      resources :items

      resources :merchants, only: [:show] do
        resources :items, only: [:index], controller: 'merchant_items'
      end
      # get '/merchants/:merchant_id/items', to: 'merchant_items#index'
    end
  end
end
