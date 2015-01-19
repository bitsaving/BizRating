class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name,
      :phone_number, :last_name, :address, :state, :pin_code)

    # devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email) }
  end
end