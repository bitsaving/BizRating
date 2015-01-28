class Business < ActiveRecord::Base

  belongs_to :category

  has_one :address
  has_one :website
  has_many :phone_numbers
  has_many :emails
  has_many :images
  has_many :timmings

  accepts_nested_attributes_for :address, :emails, :phone_numbers, :images, :website, :timmings

  validates :name, :category_id, presence: true

end
