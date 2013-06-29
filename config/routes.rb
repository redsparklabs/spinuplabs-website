SpinuplabsWeb::Application.routes.draw do
  post "contacts/create"

  resources :posts

  get "pages/index"

  get "pages/about"

  get "pages/contact"

  get "pages/blog"

  get "pages/our-process", :to => 'pages#our_process', :as => 'pages_our_process'

  #match "/blog/2013/03/12/startup-metrics-with-keen", :to => redirect("/posts/startup-metrics-with-keen")

  #match "/blog/2013/01/12/contextio-demo-contacts", :to => redirect("/posts/context-io-demo-list-contacts")

  #match "/blog/2013/01/14/contextio-demo-attachments", :to => redirect("/posts/context-io-demo-list-attachments")

  #match "/blog/2012/12/05/killing-features-vanity-metric", :to => "/posts/killing-features-is-a-vanity-metric"

  match "/blog/2012/11/29/brent-post", :to => redirect("/posts/ruby-and-mscrm-on-premise")

  match "/blog/:year/:month/:day/:slug", :to => redirect("/posts/%{slug}")

  root :to => 'pages#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
