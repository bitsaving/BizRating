class Admin::BusinessesController < Admin::BaseController

  before_action :set_business, only: :create
  before_action :load_business, only: [:update, :edit, :update_status]

  autocomplete :keyword, :name

  def index
    @q = params[:q].nil? ? Business.ransack({workflow_state_eq: 'new'}) : Business.ransack(params[:q])
    @businesses = @q.result.includes(:images).all.page(params[:page]).per(20)
    @states = (params[:q].present? && !params[:q][:address_country_eq].blank?) ? Carmen::Country.named(params[:q][:address_country_eq]).subregions : []
  end

  def new
    @business = Business.new
    @business.setup(1)
  end

  def edit
    @business.setup(params[:step])
  end

  def create
    if @business.save
      redirect_to step2_admin_business_path(@business), notice: 'Business Created'
    else
      render :new, alert: @business.errors.full_messages.to_sentence
    end
  end

  def update
    @business.keyword_form_sentence = params[:business][:keywords_attributes][0] if business_params[:keywords_attributes]
    if @business.update(business_params)
      redirect_to ["step#{ params[:step] }",:admin, @business]
    else
      render :edit, alert: @business.errors.full_messages.to_sentence
    end
  end

    ## FIXME_NISH Please shift this controller to StatesController Index action.
    ## FIXED

  def update_status
    if @business.set_status(params[:businessStatus])
      render json: [@business.status]
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end


  private

      ## FIXME_NISH Move the method in model.
      ## FIXED

    def load_business
      ## FIXME_NISH Redirect if business is not present.
      ## FIXED
      @business = Business.find_by(id: params[:id])
      redirect_to admin_businesses_path, alert: 'No Business found' unless @business
    end

    def set_business
      @business = Business.new(business_params)
    end

    ## FIXME_NISH I think we don't require this method, you can directly pass category_id from view.
    ## FIXED

    def business_params
      params.require(:business).permit(:name, :owner_name, :description, :year_of_establishment, :category_id,
        address_attributes: [:street, :state, :city, :landmark, :country, :pin_code, :building, :area, :id],
        website_attributes: [:info, :id], emails_attributes: [:info, :id, :_destroy], keywords_attributes: [],
        phone_numbers_attributes: [:info, :id, :_destroy], time_slots_attributes: [:to, :from, :id, :_destroy, days: []],
        images_attributes: [:image_file_name, :image_content_type, :image_file_size, :image_updated_at, :image, :id, :_destroy])
    end

end
