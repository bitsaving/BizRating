module ApplicationHelper
  def google_map_url(business)
     "http://maps.google.com/?q=" + business.address.latitude.to_s + ',' + business.address.longitude.to_s
  end
end
