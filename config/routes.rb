Rails.application.routes.draw do
  devise_for :users, :controllers =>
             { :registrations => "users/registrations" },
             skip: [:sessions]
  as :user do 
    get "/login" => "devise/sessions#new", as: :new_user_session
    delete "/logout" => "devise/sessions#destroy", as: :destroy_user_session
    post "/login" => "devise/sessions#create", as: :user_session
  end

  scope module: 'admin' do
    controller :sessions do
      get "/admin" => :new, as: :new_admin_session
    end
  end

  resources :home

  resources :categories
  post "categories/valid" => 'categories#valid'
  post "categories/update_status" => 'categories#update_status'
  post "categories/update_position" => 'categories#update_position'

  resource :password, only: [:edit, :update]
  resources :businesses

  root 'home#index'
end
