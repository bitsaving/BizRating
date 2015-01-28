class Address < ActiveRecord::Base

  belongs_to :business

  validates :city, :country, :state, presence: true

end
