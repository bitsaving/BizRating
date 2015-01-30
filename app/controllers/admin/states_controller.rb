class Admin::StatesController < Admin::BaseController

  def index
    ## FIXME_NISH Please shift this controller to StatesController Index action.
    ## FIXED
    render json: Carmen::Country.named(params[:country]).subregions.map {|regions| regions.name }
  end

end
