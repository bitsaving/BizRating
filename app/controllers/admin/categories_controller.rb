class Admin::CategoriesController < Admin::BaseController

  before_action :load_category, only: [:update, :update_status]

  def index
    @categories = Category.order(:position)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Created Successfully'
    else
      flash[:all] = @category.errors.full_messages
    end
    redirect_to :categories
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Updated Successfully'
    else
      flash[:notice] = @category.errors.full_messages
    end
    redirect_to :categories
  end

  def update_status
    @category.status = params[:categoryStatus] == 'true' ? false : true
    if @category.save
      render json: [@category.status]
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update_position
    params[:position].each_with_index do |id, index|
      Category.find_by(id: id).update_columns(position: index)
    end
    render json: []
  end

  private

    def load_category
      @category = Category.find_by(id: params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :image)
    end

end
