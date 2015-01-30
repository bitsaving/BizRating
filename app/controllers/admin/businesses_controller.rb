class Admin::BusinessesController < Admin::BaseController

  before_action :set_business, only: :create
  before_action :load_business, only: [:update, :edit, :update_status]
  before_action :set_status, only: :update_status
  before_action :setup, only: :edit

  autocomplete :keyword, :name

  def index
    @businesses = Business.includes(:images).all
  end

  def new
    @business = Business.new
    setup
  end

  def edit
  end

  def create
    if @business.save
      redirect_to step2_admin_business_path(@business)
    else
      render :new, alert: @business.errors.full_messages.to_sentence
    end
  end

  def update
    @business.keyword_form_sentence= params[:business][:keywords_attributes][0]
    if @business.update(business_params)
      redirect_to ["step#{ params[:step] }",:admin, @business]
    else
      render :edit, alert: @business.errors.full_messages.to_sentence
    end
  end

  def get_states
    ## FIXME_NISH Please shift this controller to StatesController Index action.
    render json: Carmen::Country.named(params[:country]).subregions.map {|regions| regions.name }
  end

  def update_status
    if @business.save
      render json: [@business.status]
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end


  private

    def set_status
      @business.status = params[:businessStatus] == 'true' ? false : true
    end

    def setup
      ## FIXME_NISH Move the method in model.
      step = params[:step] || 1
      case step
      when 1
        @business.build_address unless @business.address
      when 2
        @business.phone_numbers.build unless @business.phone_numbers.exists?
        @business.emails.build unless @business.emails.exists?
        @business.build_website unless @business.website
      when 3
        @business.time_slots.build unless @business.time_slots.exists?
        @business.images.build unless @business.images.exists?
        @business.keywords.build unless @business.keywords.exists?
      end
    end

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
