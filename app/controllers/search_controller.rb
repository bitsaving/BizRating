class SearchController < ApplicationController

  def search
    @businesses = params[:q].nil? ? [] : Business.search(params[:q]).records.page(params[:page]).per(15)
  end

end
