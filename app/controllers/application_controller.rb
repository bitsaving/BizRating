class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :update_sanitized_params, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.admin?
      businesses_path
    else
      new_home_path
    end
  end

  def after_confirmation_path_for(resource)
    root_path
  end

  ## FIXME_NISH Please move it to base_controller.
  private
    def update_sanitized_params
      ## FIXME_NISH Please proivde space before and after brackets.
      devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:bio, :name)}
    end
end
