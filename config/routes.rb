Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]

  as :user do
    ## FIXME_NISH Please use devise options to set login, logout routes.
    get "/login" => "devise/sessions#new", as: :new_user_session
    get '/admin' => 'admin/sessions#new', as: :new_admin_session
    post '/admin' => 'admin/sessions#create', as: :admin_session
    delete "/logout" => "devise/sessions#destroy", as: :destroy_user_session
    post "/login" => "devise/sessions#create", as: :user_session
  end

  resources :home

  scope module: :admin do
    resources :categories, only: [:index, :update, :create] do
      collection do
        ## FIXME_NISH Use patch.
        post :update_status
        post :update_position
      end
    end

    resource :password, only: [:edit, :update]
    resources :businesses, only: :index
  end

  root 'home#index'
end
