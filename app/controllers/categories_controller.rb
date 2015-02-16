class CategoriesController < ApplicationController

  before_action :load_category, only: :show

  def show
    #FIXME_AB: @category.businesses.published.enabled. or just @category.businesses.live. 
    @businesses = @category.businesses.with_published_state.enabled.order(:created_at).page(params[:page]).per(15)
  end

  private

    def load_category
      #FIXME_AB: What if category not found?
      @category = Category.find_by(id: params[:id])
    end

end
