Rails.application.routes.draw do

  get 'model/resources'

  root "works#index"

  get 'show/:slug', :to => 'public#show'
  get 'admin', :to => 'access#index'
  get 'login', :to => 'access#login'

  get 'faculty', :to => 'faculties#index'
  get 'faculty/:action', :to => 'faculties#action'
  post 'faculty/:action', :to => 'faculties#action'

  get 'work', :to => 'works#index'
  get 'work/:action', :to => 'works#action'
  post 'work/:action', :to => 'works#action'

  get 'weblog', :to => 'posts#index'
  get 'weblog/:action', :to => 'posts#action'
  post 'weblog/:action', :to => 'posts#action'

  post "next_palette", :to => "application#next_palette"
  post "next_logo", :to => "application#next_logo"
  post "next_gradient", :to => "application#next_gradient"
  post "next_pattern", :to => "application#next_pattern"
  post "clear_gradient", :to => "application#clear_gradient"
  post "clear_pattern", :to => "application#clear_pattern"

  match ':controller(/:action(/:id))', :via => [:get, :post]

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
