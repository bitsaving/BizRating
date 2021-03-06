class CategoriesController < ApplicationController

  before_action :load_category, only: :show

  def show
    #FIXME_AB: @category.businesses.published.enabled. or just @category.businesses.live.
    ## FIXED
    search = Business.search_nearby(@category, geolocation, user_sort_order)
    @distance = search.response.hits.hits.map { |r| r['sort'][0] }
    @businesses = search.records.live.page(params[:page]).per(10)
  end

  private

    def load_category
      #FIXME_AB: What if category not found?
      ## FIXED
      @category = Category.find_by(id: params[:id])
      redirect_to home_index_path, alert: 'No category found' unless @category
    end

    def geolocation
      { lat: cookies[:lat], lon: cookies[:lng] }
    end

    def user_sort_order
      params[:order].present? ? Hash[*params[:order].split(', ')] : {}
    end

end
