class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      render json: [@review.detail, @review.user.name, @review.rating,
        @review.business.average_rating * 20], status: :created
    else
      render json: @review.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

    def review_params
      params.require(:review).permit(:detail, :rating, :business_id)
    end

end
