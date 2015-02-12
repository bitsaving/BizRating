class CategoriesController < ApplicationController

  before_action :load_category, only: :show

  def show
    @businesses = @category.businesses.with_published_state.enabled.page(params[:page]).per(15)
  end

  private

    def load_category
      @category = Category.includes(:businesses).find_by(id: params[:id])
    end

end
