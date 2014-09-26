Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      get "/users/sign_out" => "devise/sessions#destroy", :as => :service_sign_out
      resources :group, only: [:show] do
        member do
          post   :add,    to: 'group#add_user'
          delete :remove, to: 'group#remove_user'
        end
      end
      resources :users
      resource :profile, except: [:index,:destroy,:create]
      root to: "home#index", as: :authenticated_root
    end

    unauthenticated :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end
end
