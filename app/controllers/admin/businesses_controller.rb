class Admin::BusinessesController < Admin::BaseController

  before_action :load_states  , only: :index
  before_action :load_business, only: [:update, :edit, :update_status, :fire]
  autocomplete :keyword, :name, full: true

  def index
    @q = Business.ransack(search_params)
    @businesses = @q.result(distinct: true).includes(:images).page(params[:page]).load
  end

  def new
    @business = Business.new
    ## FIXME_NISH Rewrite this method as setup(step_no: 1)
    ## FIXED
    @business.setup
  end

  def edit
    @business.setup(step_no: params[:step])
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      redirect_to step2_admin_business_path(@business), notice: 'Business Created'
    else
      render :new, alert: @business.errors.full_messages.to_sentence
    end
  end

  def update
    if @business.update(business_params)
      redirect_to ["step#{ params[:step] }",:admin, @business]
    else
      render :edit, alert: @business.errors.full_messages.to_sentence
    end
  end

  def update_status
    if @business.set_status(params[:businessStatus])
      render json: [@business.status]
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end

  def fire
    @business.fire!(params[:event])
    redirect_to ["step#{ params[:step] }",:admin, @business]
  end

  private
    def load_business
      @business = Business.find_by(id: params[:id])
      redirect_to admin_businesses_path, alert: 'No Business found' unless @business
    end

    def search_params
      params[:q].nil? ? { workflow_state_eq: 'new' } : params[:q]
    end

    def load_states
      @states = (params[:q].present? && params[:q][:address_country_eq].present?) ? Carmen::Country.named(params[:q][:address_country_eq]).subregions : []
    end

    def business_params
      params.require(:business).permit(:name, :owner_name, :description, :year_of_establishment, :category_id, :keywords_sentence, :workflow_event,
        address_attributes: [:street, :state, :city, :landmark, :country, :pin_code, :building, :area, :id],
        website_attributes: [:info, :id], emails_attributes: [:info, :id, :_destroy],
        phone_numbers_attributes: [:info, :id, :_destroy], time_slots_attributes: [:to, :from, :id, :_destroy, days: []],
        images_attributes: [:image_file_name, :image_content_type, :image_file_size, :image_updated_at, :image, :id, :_destroy])
    end

end
