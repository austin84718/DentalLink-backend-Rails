ReferralServerRuby::Application.routes.draw do
  #devise_for :users, controllers: {sessions:'sessions', registrations: 'registrations', passwords: 'passwords'}, token_authentication_key: 'authentication_token'

  devise_for :users, controllers: {sessions:'sessions', registrations: 'registrations', passwords: 'passwords'}, skip: [:sessions, :registrations, :passwords, :confirmations], token_authentication_key: 'authentication_token'
  as :user do
    post '/sign_in' => 'sessions#create', as: :user_session
    delete '/sign_out' => 'sessions#destroy', as: :destroy_user_session
    get '/sign_in' => 'sessions#new', as: :new_user_session

    post '/confirm' => 'devise/confirmations#create'
    get '/confirm/new' => 'devise/confirmations#new', as: :new_user_confirmation
    get '/confirm' => 'devise/confirmations#show', as: :user_confirmation

    get '/sign_up' => 'registrations#new', as: :new_user_registration
    post '/sign_up' => 'registrations#create'
    put '/users' => 'registrations#update'
    delete '/users' => 'registrations#destroy'

    post '/password' => 'passwords#create'
    get '/password' => 'passwords#new', as: :new_user_password
    get '/password/edit' => 'passwords#edit', as: :edit_user_password
  end



  resources :addresses

  resources :patients

  resources :referrals

  resources :practices

  #resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'referrals#index'

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
