Rails.application.routes.draw do

  devise_for :users, controllers: {sessions: "sessions"}

  devise_scope :user do
    authenticated :user do
      get "/users/sign_out" => "devise/sessions#destroy", :as => :service_sign_out
      resources :users
      resources :groups do
        member do
          post   :add,    to: 'groups#add_user'
          delete :remove, to: 'groups#remove_user'
        end
      end
      resource :profile, except: [:index,:destroy,:create]
      root to: "profiles#show", as: :authenticated_root
    end



    unauthenticated :user do
      root to: "sessions#new", as: :unauthenticated_root

      get "/setup" => "setup#index"
      post "/setup/create" => "setup#create"
    end
  end

end
