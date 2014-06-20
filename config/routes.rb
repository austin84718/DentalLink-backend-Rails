ReferralServerRuby::Application.routes.draw do

  resources :procedures, defaults: {format: :json}

  #devise_for :users, controllers: {sessions:'sessions', registrations: 'registrations', passwords: 'passwords'}, token_authentication_key: 'authentication_token'

  devise_for :users, path: '', path_names: {registration: 'sign_up'}, controllers: {sessions: :sessions, registrations: :registrations, passwords: :passwords}, token_authentication_key: 'authentication_token'

  resources :addresses, defaults: {format: :json}

  resources :attachments, defaults: {format: :json}

  resources :notes, defaults: {format: :json}

  resources :patients, defaults: {format: :json} do
    get :search, to: 'patients#search', on: :collection
  end

  resources :referrals, defaults: {format: :json} do
    post :template, to: 'referrals#save_template', on: :new
    put :status, to: 'referrals#change_status', on: :member
    get 'practice/:id', to: 'referrals#referrals_by_practice', on: :collection
  end

  resources :practices, defaults: {format: :json} do
    get :search, to: 'practices#search', on: :collection
  end

  resources :practice_invitations, only: [:create, :destroy], defaults: {format: :json}

  get :s3, to: 'attachments#s3_credentials', defaults: {format: :json}

  get 'invitations/:invitation_token', to: 'provider_invitations#show', defaults: {format: :json}
  get 'invitees/:user_id', to: 'provider_invitations#invitees', defaults: {format: :json}
  post 'invitations', to: 'provider_invitations#create', defaults: {format: :json}
  delete 'invitations/:id', to: 'provider_invitations#destroy', defaults: {format: :json}


  get :providers, to: 'users#doctors', defaults: {format: :json}
  get :users, to: 'users#index', defaults: {format: :json}
  get 'users/:id', to: 'users#show', defaults: {format: :json}
  post :users, to: 'users#invite', defaults: {format: :json}
  delete 'users/:id', to: 'users#destroy', defaults: {format: :json}
  put 'users/:id', to: 'users#update', defaults: {format: :json}

  get 'login', to: redirect('/pages/dentalLinks.html')

  get :practice_types, to: "procedures#practice_types"
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
