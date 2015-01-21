class CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :load_category, only: [:destroy, :show, :update, :edit]
  before_action :set_category, only: [:create, :valid]

  def index
    @categories = Category.all.reverse
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to :categories
    else
      flash[:notice] = @categories.errors
      redirect_to :categories
    end
  end

  def update
    if @category.update(category_params)
      redirect_to :categories
    else
      flash[:notice] = @categories.errors
      redirect_to :categories
    end
  end

  def destroy
    @category.destroy
    render nothing: true
  end

  def valid
    if valid_name?
      render json: []
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update_status
    @category = Category.find_by(id: params[:categoryId])
    @category.status = params[:categoryStatus] == 'true' ? false : true
    if @category.save
      render json: [@category.status]
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  private
    def valid_name?
      @category.errors.add('image', " ")
      if @category.name.strip == ""
        @category.errors.add('name', "can't blank")
        return false
      elsif Category.find_by(name: @category.name)
        @category.errors.add('name', 'is already taken')
        return false
      else
        return true
      end          
    end

    def set_category
      @category = Category.new(category_params)
    end

    def load_category
      @category = Category.find_by(id: params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :image)
    end
end
