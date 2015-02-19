class ReviewsController < ApplicationController
  skip_before_action :authorize
  before_action :load_review, only: :update

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      render json: [@review.detail, @review.user.name, @review.rating,
        @review.business.average_rating * 20], status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      render json: [@review.detail, @review.user.name, @review.rating,
        @review.business.average_rating * 20], status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  private
    def load_review
      @review = Review.find_by(id: params[:id])
      render json: ['Invalid Review'], status: :unprocessable_entity unless @review
    end

    def review_params
      params.require(:review).permit(:detail, :rating, :business_id)
    end
end
