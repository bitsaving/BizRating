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
        patch :update_status
        patch :update_position
      end
    end

    resource :password, only: [:edit, :update]
    resources :businesses, except: :new do
      collection do
        get 'step1' => 'businesses#new', defaults: {step: 1}
        post :update_states
      end
      member do
        get 'step1' => 'businesses#edit', defaults: {step: 1}
        get 'step2' => 'businesses#edit', defaults: {step: 2}
        get 'step3' => 'businesses#edit', defaults: {step: 3}
        patch 'step1' => 'businesses#update', defaults: {step: 1}
        patch 'step2' => 'businesses#update', defaults: {step: 2}
        patch 'step3' => 'businesses#update', defaults: {step: 3}
      end
    end
  end

  root 'home#index'

end
