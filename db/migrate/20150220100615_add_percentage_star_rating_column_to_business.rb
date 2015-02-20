class AddPercentageStarRatingColumnToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :percentage_star_rating, :text
  end
end
