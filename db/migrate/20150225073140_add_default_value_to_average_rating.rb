class AddDefaultValueToAverageRating < ActiveRecord::Migration
  def change
    change_column_default :businesses, :average_rating, 0.0
  end
end
