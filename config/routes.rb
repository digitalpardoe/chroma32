Chroma32::Application.routes.draw do |map|
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  
  # Routes to allow the user's browser to download file such as theme and
  # plugins resources and the documents uploaded to the application
  match "theme/:resource/:filename(.:format)" => "admin/themes#show", :as => :theme_resource
  match "plugin/:name/:resource/:filename(.:format)" => "admin/plugins#show", :as => :plugin_resource
  match "download/:catalog_id/:type/:id(.:format)" => "admin/documents#download", :type => /file|thumbnail/, :as => :file_download

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
  
  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resource :user_session, :only => [:new, :create, :destroy]

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  namespace :admin do
    root :to => "admin#index"
        
    resources :users
    resources :roles, :except => [:show]
    resources :themes, :only => [:index, :update]
    resources :settings, :only => [:index, :update]
    
    # Nested resources to allow catalogs to exist inside catalogs and
    # documents to exist inside catalogs
    resources :catalogs, :only => [:index, :show, :edit, :update, :destroy] do
      resources :documents, :except => [:index]
      resource :catalog, :only => [:create, :new]
    end
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  
  # Set the root of the application if it set up in the database,
  # in the event it is not, set it to a known default
  begin
    root :to => Setting.application.value("root")
  rescue
    root :to => "user_sessions#new"
  end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
