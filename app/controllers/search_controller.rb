class SearchController < ApplicationController

  def search
    @businesses = params[:q].nil? ? [] : Business.search(params[:q]).records.order(average_rating: :desc, created_at: :asc).page(params[:page]).per(15)
  end

end
