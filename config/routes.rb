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
  get 'jubiläum', action: :anniversary, controller: :index, as: :anniversary

  get 'login' => 'user_sessions#new', as: :login
  match 'logout' => 'user_sessions#destroy', via: [:delete, :get], as: :logout

  resources :photo_albums, path: '/photos' do
  end

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

  resources :users do
    member do
      get 'password', action: :edit_password, as: :edit_password
      patch'password', action: :update_password, as: :update_password
    end
  end

  root to: 'index#index', as: :index
end
