Pfadismn::Application.routes.draw do

  get 'pfadilife/videos', as: :pfadilife_videos
  get 'pfadilife/skauty', as: :pfadilife_skauty
  get 'pfadilife/', action: :index, controller: :pfadilife, as: :pfadilife_index
  
  get 'dashboard', action: :dashboard, controller: :index, as: :dashboard
  get 'downloads', action: :downloads, controller: :index, as: :downloads
  get 'jahresprogramm', action: :jahresprogramm, controller: :index, as: :jahresprogramm
  get 'impressum', action: :impressum, controller: :index, as: :impressum
  get 'rheinfallmarsch', action: :rheinfallmarsch, controller: :index, as: :rheinfallmarsch
  get 'chronik', action: :chronik, controller: :index, as: :chronik
  get 'faq', action: :faq, controller: :index, as: :faq

  get 'login' => 'user_sessions#new', as: :login
  match 'logout' => 'user_sessions#destroy', via: [:delete, :get], as: :logout
    
  match 'photos' => 'photos#destroy', via: [:delete]
  match 'photos' => 'photos#create', via: [:post] , as: :photo_collection_album_uploads
  get 'photos/new' => 'photos#new' , as: :new_photo
  get 'photos/:year' => 'photos#index' , as: :photo_year
  get 'photos/:year/:id' => 'photos#show', as: :photo_album

  get 'treasurehunt' => 'index#jubilaeum2014'
  get '70jahre' => 'index#jubilaeum2014', as: :jubilaeum2014
  get 'anmeldung70jahre', action: :new, controller: :alumni_addresses, as: :new
  
  resources :organisational_units, path: :abteilung do
    resources :contact_forms
    resources :events do
      collection do
        get :quartalsprogramm
      end
      member do
        get 'image(/:size)(.:format)', action: :image, default: { size: :large }, as: :image
      end
    end
    resources :members do
      resources :addresses
      resources :phone_numbers
      resources :contacts
      member do
        get 'avatar(/:size)(.:format)', action: :avatar, default: { size: :medium }, as: :avatar
      end
    end
  end
  
  resources :places
  resources :news
  resources :user_sessions
  resources :password_resets
  resources :photos
  resources :meeting_protocols
  resources :mail_aliases
  
  resources :users do
    member do
      get 'password', action: :edit_password, as: :edit_password
      patch'password', action: :update_password, as: :update_password
    end
  end
  

  root to: 'index#index', as: :index
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
  # match ':controller(/:action(/:id(.:format)))'
end
