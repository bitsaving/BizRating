class Address < ActiveRecord::Base

  belongs_to :business, required: true

  validates :city, :country, :state, :pin_code, presence: true

  validates :pin_code, format: /\A\d+\z/, allow_blank: true

end
