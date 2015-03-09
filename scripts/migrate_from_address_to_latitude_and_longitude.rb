require '../config/environment.rb'
require 'net/http'

puts 'transforming address to latitude and longitude'
Address.find_each do |address|
  uri = URI.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=" + [address.latitude, address.longitude].join(',') + "&key=AIzaSyDsihJMaLwegcz19Wfle-gDtTyAeBmaLK4")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  p Active::Support::JSON.decode(response.body)['results'][0]['geometry']['location']
end
