Rails.application.routes.draw do

  devise_for :users, skip: [ :sessions ]
  as :user do
    post '/api/v1/login' => 'api/v1/sessions#create'
    get '/api/v1/current_user' => 'api/v1/sessions#show'
  end

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do

      resources :productions, only: [:index, :show, :create, :update, :destroy]

      resources :users, only: [:index, :show, :create, :update, :destroy] do
        get 'tickets', on: :member
        put 'unlock', on: :member
        put 'lock', on: :member
        put 'change_role', on: :member
      end

      resources :clients, only: [:index, :show, :create, :update, :destroy] do
        get 'search', on: :collection
        resources :comments, controller: 'client_comments', only: [:index, :show, :create, :update, :destroy]
        resources :friends, controller: 'client_friendships', only: [:index, :create, :destroy] do
          get 'count', on: :collection
        end
        resources :tickets, only: [:index, :show, :create, :update, :destroy] do
          put 'checkin', on: :member
          put 'change_price', on: :member
          get 'current_event', on: :collection
        end
        resources :events, only: [] do
          get 'count_friends_tickets', on: :member
        end
      end

      resources :events, only: [:index, :show, :create, :update, :destroy] do
        get 'tickets', on: :member
        get 'upcoming', on: :collection
        resources :prices, controller: 'event_prices', only: [:index, :show, :create, :update, :destroy]
      end

    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
