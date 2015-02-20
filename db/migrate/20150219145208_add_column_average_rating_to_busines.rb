class AddColumnAverageRatingToBusines < ActiveRecord::Migration
  def change
    add_column :businesses, :average_rating, :decimal, scale: 2, precision: 4
    Business.reset_column_information
    Business.all.each do |business|
      business.update(average_rating: business.reviews.average(:rating))
    end
  end
end
