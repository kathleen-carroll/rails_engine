Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:merchant_id/items', to: 'items#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#show_all'
        get '/most_revenue', to: 'business#most_revenue'
      end
      resources :merchants, only: [:index, :create, :show, :update, :destroy]

      namespace :items do
        get '/:id/merchant', to: 'merchants#show'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#show_all'
      end
      resources :items
    end
  end
end
