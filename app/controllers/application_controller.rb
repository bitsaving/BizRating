class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  layout :users_layout

  def after_sign_in_path_for(resource)
    if resource.is_admin?
      businesses_path
    else
      new_home_path
    end
  end

  def after_confirmation_path_for(resource)
    root_path
  end

  def authenticate_admin!
    if !(user_signed_in? && current_user.is_admin?)
      redirect_to new_user_session_path
    end
  end

  def users_layout
    (user_signed_in? && current_user.is_admin?) ? 'admin' : 'application'
  end

end
