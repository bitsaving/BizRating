class BusinessesController < ApplicationController

  before_action :load_business_and_reviews, only: :show
  before_action :load_business_reviews, only: :show
  before_action :user_review, only: :show

  def show
  end

  private

    def load_business_and_reviews
      @business = Business.includes(:address, :images, :time_slots, :emails, :phone_numbers, :website, :category).find_by(id: params[:id])
    end

    def load_business_reviews
      @reviews = @business.reviews.order(created_at: :desc).page(params[:page]).per(15)
    end

    def user_review
      @user_review = @business.reviews.build if user_signed_in? && @business.reviews.find_by(user_id: current_user.id).nil?
    end

end
