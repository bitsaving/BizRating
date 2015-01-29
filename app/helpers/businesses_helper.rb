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

  def day_checked(day, object)
    # p object
    # p !object.new_record?
    # p object.days.include? day.to_s
    ((!object.new_record?) && (object.days.include? day.to_s))
    # .days.include? day
    # object.days.include? day
  end
end
