class Admin::StatesController < Admin::BaseController

  def index
    render json: Carmen::Country.named(params[:country]).subregions.map { |region| region.name }
  end

end
