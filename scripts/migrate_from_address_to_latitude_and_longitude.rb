require '../config/environment.rb'
require 'net/http'

puts 'transforming address to latitude and longitude'
Address.find_each do |address|
  uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?" + address.area.to_query('address') + "&key=AIzaSyDsihJMaLwegcz19Wfle-gDtTyAeBmaLK4")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  response = ActiveSupport::JSON.decode(http.request(request).body)
  if response['results'].empty?
    location = { latitude: 0, longitude: 0 }
  else
    location = { latitude: response['results'][0]['geometry']['location'][:lng], longitude: response['results'][0]['geometry']['location']['lng']}
  end
  p location
end
