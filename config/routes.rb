Rails.application.routes.draw do
  resources :stages

  resources :rooms

  #resources :bids

  resources :realtors

  resources :clients

  resources :template_room_items

  resources :items

  devise_for :admins
  devise_for :users, :controllers => { :registrations => "registrations" } 
  
  resources :properties
  get 'home/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'home#index'

   get 'pricing_proposal/:id' => 'pricing_proposal#index'
   post 'home/find_bids' => 'home#find_bids'
   get 'bids/edit/:id' => 'bids#edit'
   get 'bids/show/:id' => 'bids#show'
   get 'bids/step1/:id' => 'bids#step1'
   get 'bids/step2/:id' => 'bids#step2'
   get 'stages/edit/:id' => 'stages#edit'
   post 'bids/editproc' => 'bids#editproc'
   post 'bids/step2proc' => 'bids#step2proc'
   post 'bids/step1proc' => 'bids#step1proc'
   get 'bids/step3' => 'bids#step3'
   get 'bids/step3/:id' => 'bids#step3'
   post 'bids/step3proc' => 'bids#step3proc'
   get 'bids/step4' => 'bids#step4'
   get 'bids' => 'bids#index'
   get '/item(:json)' => 'item#index'
   get '/item/index' => 'item#index'
   get '/item' => 'item#index'
   get '/bids/step1' => 'bids#step1'
   get '/property/search' => 'property#search'
   get '/client/search' => 'client#search'
   get '/realtor/search' => 'realtor#search'
     
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
     resources :items

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
