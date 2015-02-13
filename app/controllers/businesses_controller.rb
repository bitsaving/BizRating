class BusinessesController < ApplicationController

  def show
    @business = Business.includes(:address, :images, :time_slots, :emails, :phone_numbers, :website, :category).find_by(id: params[:id])
  end

end
