module RegistrationsHelper

  def registration_error_class(field_name)
    resource.errors[field_name].empty? ? '' : 'has-error'
  end

end