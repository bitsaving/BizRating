class Business < ActiveRecord::Base

  belongs_to :category, required: true

  has_one :address, dependent: :destroy
  has_one :website, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :timmings, dependent: :destroy

  accepts_nested_attributes_for :address, :images, :timmings, allow_destroy: true

  accepts_nested_attributes_for :emails, :website, :phone_numbers, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:details].blank? }

  validates :name, presence: true

  validates :year_of_establishment, numericality: { only_integer: true, greater_than: 0, less_than: 9999 }

end
