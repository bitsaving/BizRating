require '../config/environment.rb'

puts 'Updating average_rating'
Business.find_each do |business|
  business.update(average_rating: business.reviews.average(:rating))
end

puts 'Updating percentage_star_rating'
Business.find_each do |business|
  business.update_percentage_star_rating
end
