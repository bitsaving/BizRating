class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :device_signup_params, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_businesses_path
    else
      home_index_path
    end
  end

  def after_confirmation_path_for(resource)
    root_path
  end

  private
  #FIXME_AB: This method is devise specific so should be name something similar. Ex; device_signup_params
  ## FIXED
    def device_signup_params
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name) }
    end
end
