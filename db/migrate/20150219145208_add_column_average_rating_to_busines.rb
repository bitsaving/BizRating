class AddColumnAverageRatingToBusines < ActiveRecord::Migration
  def change
    add_column :businesses, :average_rating, :decimal, scale: 2, precision: 4
  end
end
