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
    @business.normalize_business_keywords
    if @business.save
      redirect_to step2_admin_business_path(@business)
    else
      flash.now[:alert] = @business.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @business.update(set_params)
      redirect_to ["step#{ params[:step] }",:admin, @business]
    else
      flash.now[:alert] = @business.errors.full_messages.to_sentence
      render :edit
    end
  end

  def get_states
    ## FIXME_NISH Please shift this controller to StatesController Index action.
    render json: Carmen::Country.named(params[:country]).subregions.map {|regions| regions.name }
  end

  def destroy
    @business.destroy
    redirect_to admin_businesses_path
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
      @business = Business.find_by(id: params[:id])
    end

    def set_params
      if (business_params[:category])
        normalize_parameters
      else
        business_params
      end
    end

    def load_category
      Category.find_by(id: business_params[:category].to_i)
    end

    def set_business
      @business = Business.new(normalize_parameters)
    end

    def normalize_parameters
      ## FIXME_NISH I think we don't require this method, you can directly pass category_id from view.
      parameters = business_params
      parameters[:category] = load_category
      parameters
    end

    def business_params
      params.require(:business).permit(:name, :owner_name, :description, :year_of_establishment, :category,
        address_attributes: [:street, :state, :city, :landmark, :country, :pin_code, :building, :area, :id],
        website_attributes: :details, emails_attributes: [:details, :id, :_destroy], keywords_attributes: [:name, :id, :_destroy],
        phone_numbers_attributes: [:details, :id, :_destroy], time_slots_attributes: [:to, :from, :id, :_destroy, days: []],
        images_attributes: [:image_file_name, :image_content_type, :image_file_size, :image_updated_at, :image, :id, :_destroy])
    end

end
