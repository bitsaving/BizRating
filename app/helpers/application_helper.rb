module ApplicationHelper
  def google_map_url(business)
    "http://maps.google.com/?q=" + business_latitude_longitude(business)
  end

  def google_static_map_url(business)
    "https://maps.googleapis.com/maps/api/staticmap?center=" + business_latitude_longitude(business) + '&zoom=16&size=330x140&markers=color:red%7Clabel:S%7C' + business_latitude_longitude(business)
  end

  def business_latitude_longitude(business)
    if business.address.latitude && business.address.longitude
      [business.address.latitude, business.address.longitude].join(',')
    end
  end
end
