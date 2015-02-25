class Review < ActiveRecord::Base

  after_save :update_average_business_rating
  after_save :update_percentage_star_rating

  belongs_to :user
  belongs_to :business

  validates :detail, :rating, :user_id, :business_id, presence: true
  validates :detail, length: { maximum: 500 }, allow_blank: true
  validates :rating, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 5 }, allow_blank: true
  validates :user_id, uniqueness: { scope: :business_id }, allow_blank: true

  private

    def update_average_business_rating
      business.update_column(:average_rating, business.reviews.average(:rating))
    end

    def update_percentage_star_rating
      business.update_column(:percentage_star_rating, Hash[reviews.group(:rating).count(:rating).map{ |k,v| [k, v.to_i * 100 / reviews.count] }])
    end

end
