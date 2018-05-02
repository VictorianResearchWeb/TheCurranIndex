Rails.application.routes.draw do

  root 'articles#index'
  get 'contributors' => 'contributors#index'
  get 'advanced_search' => 'articles#advanced_search'

  get 'history' => 'static_pages#history'
  get 'sites' => 'static_pages#sites'
  get 'scholarship' => 'static_pages#scholarship'
  get 'contact' => 'static_pages#contact'

  #needed for jquery filters
  get 'date_range' => 'articles#date_range'
  get 'advanced_date_range' => 'articles#advanced_date_range'
  get 'title_search' => 'articles#title_search'
  get 'advanced_title_search' => 'articles#advanced_title_search'
  get 'aggregation_change' => 'articles#aggregation_change'
  get 'download' => 'articles#download'
  get 'download_contributors' => 'contributors#download'
  get 'full_name_search' => 'contributors#full_name_search'


#  get 'static/:page_key' => 'static_pages#show'

#  get '/contributor' => 'articles#contributor', as: :contributor

  resources :essays, only: [:index]

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
