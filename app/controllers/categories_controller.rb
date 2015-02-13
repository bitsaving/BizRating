class CategoriesController < ApplicationController

  before_action :load_category, only: :show

  def show
    @businesses = @category.businesses.with_published_state.enabled.order(:created_at).page(params[:page]).per(15)
  end

  private

    def load_category
      @category = Category.find_by(id: params[:id])
    end

end
