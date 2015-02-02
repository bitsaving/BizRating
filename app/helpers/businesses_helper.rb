module BusinessesHelper
  def step(step_input)
    "step#{ step_input }"
  end

  def add_error_class(field_name)
    @business.errors[field_name].empty? ? '' : 'has-error'
  end

  def error_span(field_name)
    # content_tag :span { @business.errors[field_name][0] }
  end

end
