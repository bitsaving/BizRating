class Admin::CategoriesController < Admin::BaseController

  before_action :load_category, only: [:update, :update_status]

  def index
    #FIXME_AB: Lets not load them here. just use  Category.order(:position). : lazy loading
    @categories = Category.order(:position).load
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      #FIXME_AB: You may want to interpolate category name in the flash message. Similarly at other places
      flash[:notice] = 'Category added Successfully'
      redirect_to admin_categories_path
    else
      #FIXME_AB: Prefer symbol over string render :new
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

  #FIXME_AB: I would prefer to have enable and disable two methods for enabling disabling. Makes more readable and simpler for testing
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
      #FIXME_AB: this will fire too much of find queries please optimize
      @category = Category.find_by(id: params[:id])
      redirect_to admin_categories_path, alert: 'No category found' unless @category
    end

    def category_params
      params.require(:category).permit(:name, :image)
    end

end
