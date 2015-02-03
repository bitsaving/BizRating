class Admin::CategoriesController < Admin::BaseController

  before_action :load_category, only: [:update, :update_status]

  def index
    @categories = Category.order(:position).load
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Created Successfully'
      redirect_to admin_categories_path
    else
      flash.now[:alert] = @category.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Updated Successfully'
    else
      flash[:alert] = @category.errors.full_messages.to_sentence
    end
    redirect_to admin_categories_path
  end

  def update_status
    ## FIXME_NISH Use snake_case.
    if @category.set_status(params[:categoryStatus])
      render json: [@category.status]
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def update_position
    ## FIXME_NISH Please refactor this.
    params[:position].each_with_index do |id, index|
      Category.find_by(id: id).update_columns(position: index)
    end
    render json: []
  end

  private

    def load_category
      @category = Category.find_by(id: params[:id])
      redirect_to admin_categories_path, alert: 'No category found' unless @category
    end

    def category_params
      params.require(:category).permit(:name, :image)
    end

end
