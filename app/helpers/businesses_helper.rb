module BusinessesHelper
  def step(step_input)
    "step#{ step_input }"
  end

  def add_error_class(field_name)
    @business.errors[field_name].empty? ? '' : 'has-error'
  end

  def error_placeholder_text(field_name)
    @business.errors[field_name].empty? ? '' : @business.errors[field_name].to_sentence
  end
end
