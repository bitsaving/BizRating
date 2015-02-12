class BusinessesController < ApplicationController

  before_action :load_business

  def show
    @business
  end

  private

    def load_business
      @business = Business.includes(:address, :images, :time_slots, :emails, :phone_numbers, :website, :category).find_by(id: params[:id])
    end

end
