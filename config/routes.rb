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
        get '/new/step1' => 'businesses#new', as: :new_step1, defaults: {step: 1}
        post :update_states
      end
      member do
        get 'edit/step1' => 'businesses#edit', as: :edit_step1, defaults: {step: 1}
        get 'edit/step2' => 'businesses#edit', as: :edit_step2, defaults: {step: 2}
        get 'edit/step3' => 'businesses#edit', as: :edit_step3, defaults: {step: 3}
        patch 'update/step1' => 'businesses#update', as: :update_step1, defaults: {step: 1}
        patch 'update/step2' => 'businesses#update', as: :update_step2, defaults: {step: 2}
        patch 'update/step3' => 'businesses#update', as: :update_step3, defaults: {step: 3}
      end
    end
  end

  root 'home#index'

end
