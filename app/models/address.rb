class Address < ActiveRecord::Base

  belongs_to :business, required: true

  validates :city, :country, :state, presence: true

  validates :pin_code, presence: true, format: /\A\d+\z/

end
