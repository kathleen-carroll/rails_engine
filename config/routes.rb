Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :create, :show, :update, :destroy]
      namespace :merchants do
        get '/:merchant_id/items', to: 'items#index'
      end

      resources :items
    end
  end
end
