class Review < ActiveRecord::Base

  belongs_to :user
  belongs_to :business

  validates :detail, :rating, :user_id, :business_id, presence: true
  validates :detail, length: { maximum: 500 }, allow_blank: true
  validates :rating, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 5 }, allow_blank: true
  validates :user_id, uniqueness: { scope: :business_id }, allow_blank: true

end
