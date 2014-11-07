SparklePony::Application.routes.draw do

  # login in is the most important!
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get "sessions/new"

  get "sessions/create"

  get "sessions/destroy"

  get "user/info"

  # query routes
  match "user/query/create", :controller => "user/query",
                             :action => "create",
                             :via => :post

  get '/user/query/update_history'

  get '/user/query', :to => 'user/query#consolidated'

  get "user/query/show/:id", :to => 'user/query#show', :as => 'query_show'

  get '/user/query/history', :to =>'user/query#history'

  get 'user/query/render_output'

  get 'user/query/render_history'

  # dashboard routes
  get "user/dashboards/home" =>"user/dashboards#home"

  get "user/dashboards/new" => "user/dashboards#new"

  get "user/dashboards/:id/edit" => "user/dashboards#edit",
                             :as => :dashboard_edit

  get "user/dashboards/:id/delete" => "user/dashboards#delete",
                               :as => :dashboard_delete

  get "user/dashboards/:id" => "user/dashboards#show",
                          :as => :dashboard_thing

  #updating dashboards
  match "user/dashboards/update_name/:id", :controller => "user/dashboards",
                                           :action     => "update_name",
                                           :via        => "put"

  match "user/dashboards/update_query/:id", :controller => "user/dashboards",
                                  :action     => "update_query",
                                  :via        => "put"

  match "user/dashboards/update_cols/:id", :controller => "user/dashboards",
                                       :action     => "update_cols",
                                       :via        => "put"

  # we need these to create dashboards
  match "user/dashboards/create",      :controller => "user/dashboards",
                                       :action     => "create",
                                       :via        => "post"

  match "user/dashboards/get_col_names",  :controller => "user/dashboards",
                                          :action     => "get_col_names",
                                          :via        => "post"

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
  root :to => 'sessions#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
