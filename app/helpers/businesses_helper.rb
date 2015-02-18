module BusinessesHelper
  def step(step_input)
    "step#{ step_input }"
  end

  def add_error_class(field_name)
    @business.errors[field_name].empty? ? '' : 'has-error'
  end

  #FIXME_AB: method returning boolean value. should be ? method
  #FIXED
  def day_checked?(day, object)
    #FIXME_AB: use object.persisted?
    #FIXED
    ((object.persisted?) && (object.days.include? day.to_s))
  end

  def active_class(index)
    index == 0 ? 'active' : ''
  end

  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end
end
