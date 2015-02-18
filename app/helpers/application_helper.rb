module ApplicationHelper
  def google_map_url(business)
     "http://maps.google.com/?" + business.address.area.to_query('q')
  end
end
