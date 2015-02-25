Rails.application.routes.draw do
  devise_for :users

  as :user do
    ## FIXME_NISH Please use devise options to set login, logout routes.
    ## FIXED
    get '/admin' => 'admin/sessions#new', as: :new_admin_session
    post '/admin' => 'admin/sessions#create', as: :admin_session
  end

  resources :home, only: :index
  resources :businesses, only: :show
  resources :categories, only: :show
  resources :reviews, only: [:create, :update]

  namespace :admin do
    resources :categories, only: [:index, :update, :create] do
      collection do
        ## FIXME_NISH Use patch.
        ## FIXED
        patch :update_status
        patch :update_position
      end
    end

    resource :password, only: [:edit, :update]
    resources :states, only: :index
    resources :businesses, path_names: { new: :step1 } do
      patch :fire, on: :member
      collection do
        ## FIXME_NISH Use GET for this action and move this action to StatesController Index action.
        ## FIXED
        get :autocomplete_keyword_name
        patch :update_status
      end

      member do
        get :step1, to: :edit, defaults: { step: 1 }
        get :step2, to: :edit, defaults: { step: 2 }
        get :step3, to: :edit, defaults: { step: 3 }
        patch :step1, to: :update, defaults: { step: 1 }
        patch :step2, to: :update, defaults: { step: 2 }
        patch :step3, to: :update, defaults: { step: 3 }
      end
    end

    resources :users, only: :index do
      patch :update_status, on: :collection
    end
  end

  root 'home#index'

end
