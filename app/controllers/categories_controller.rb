class CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :load_category, only: [:destroy, :show, :update, :edit]
  
  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to :categories
    else
      redirect_to :categories
    end
  end

  def update
    if @category.update(category_params)
      redirect_to :categories
    else
      redirect_to :categories
    end
  end

  def destroy
    @category.destroy
    render nothing: true
  end

  private
    def load_category
      @category = Category.find_by(id: params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :image)
    end
end
