module AdminHelper
  def add_class(link_for)
    controller_name == link_for ? 'active' : ''
  end

  def edit_button_class(status)
    status ? 'btn-danger' : 'btn-success'
  end
end
