ReferralServerRuby::Application.routes.draw do
  #devise_for :users, controllers: {sessions:'sessions', registrations: 'registrations', passwords: 'passwords'}, token_authentication_key: 'authentication_token'

  devise_for :users, path: '', path_names: {  registration: 'sign_up'}, controllers: {sessions: :sessions, registrations: :registrations, passwords: :passwords}, token_authentication_key: 'authentication_token'

  resources :addresses, defaults: {format: :json}

  resources :attachments, defaults: {format: :json}

  resources :notes, defaults: {format: :json}

  resources :patients, defaults: {format: :json}

  resources :referrals, defaults: {format: :json} do
    put :status, to: 'referrals#change_status', on: :member
  end

  resources :practices, defaults: {format: :json}

  resources :practice_invitations, only: [:create, :destroy], defaults: {format: :json}

  get :s3, to: 'attachments#s3_credentials', defaults: {format: :json}

  get :users, to: 'users#index'

  get 'login',to: redirect('/pages/dentalLinks.html')

  #match 'sign_in', to: 'users#index',  via: 'OPTIONS'
  #we don't need users as a resourceful route, since we have authentication framework that handles registrations and other things
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
