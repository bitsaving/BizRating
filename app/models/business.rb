class Business < ActiveRecord::Base

  belongs_to :category, required: true

  has_one :address, dependent: :destroy
  has_one :website, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :time_slots, dependent: :destroy
  has_and_belongs_to_many :keywords

  accepts_nested_attributes_for :address, :images, :time_slots, :keywords, allow_destroy: true

  accepts_nested_attributes_for :emails, :website, :phone_numbers, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:info].blank? }

  attr_accessor :keywords_attributes

  validates :name, presence: true

  validates :year_of_establishment, numericality: { only_integer: true, greater_than: 0, less_than: 9999 }

  def keyword_form_sentence=(sentence)
    self.keywords = sentence.split(',').map { |keyword| Keyword.find_or_create_by(name: keyword.strip) } if sentence
  end

  

end
