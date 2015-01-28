class Address < ActiveRecord::Base

  belongs_to :business

  validates :city, :country, :state, :pin_code, presence: true

end
