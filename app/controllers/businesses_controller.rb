class BusinessesController < ApplicationController

  def show
    @business = Business.includes(:address, :images, :time_slots, :emails, :phone_numbers, :website, :category, :reviews).find_by(id: params[:id])
    @reviews = @business.reviews.order(created_at: :desc).page(params[:page]).per(15)
    @review = Review.new(business_id: @business.id) if user_signed_in? && @business.reviews.find_by(user_id: current_user.id).nil?
  end

end
