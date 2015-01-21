module AdminHelper
  def add_class(link_for)
    controller_name == link_for ? 'active' : ''
  end
end