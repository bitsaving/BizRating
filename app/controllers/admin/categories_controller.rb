class Admin::CategoriesController < Admin::BaseController

  before_action :load_category, only: [:update, :update_status]

  def index
    ## FIXME_NISH Please don't run the query in views.
    @categories = Category.order(:position)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Created Successfully'
    else
      ## FIXME_NISH Please use to_sentence.
      ## FIXME_NISH Please use alert instead of all.
      flash[:all] = @category.errors.full_messages
    end
    redirect_to :categories
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Updated Successfully'
    else
      ## FIXME_NISH Please use to_sentence.
      ## FIXME_NISH Please use alert instead of notice.
      flash[:notice] = @category.errors.full_messages
    end
    redirect_to :categories
  end

  def update_status
    ## FIXME_NISH Refactor this code.
    @category.status = params[:categoryStatus] == 'true' ? false : true
    if @category.save
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
      ## FIXME_NISH Please check that the category is present or not.
      @category = Category.find_by(id: params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :image)
    end

end
