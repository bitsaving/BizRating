class SearchController < ApplicationController

  def search
    if params[:q].nil?
      @businesses = []
    else
      @businesses = Business.__elasticsearch__.search params[:q]
    end
  end

end
