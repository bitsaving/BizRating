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

  def current_step(business)
    [step(params[:step]), :admin, business]
  end

  def previous_step(business)
    [step(params[:step] - 1), :admin, business]
  end

  def next_step(business)
    [step(params[:step] + 1), :admin, business]
  end

  def business_rating_bar_width(rate_value)
    @business.percentage_rating_for(rate_value) * 0.9
  end

end
