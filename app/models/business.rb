class Business < ActiveRecord::Base

  belongs_to :category, required: true

  has_one :address, dependent: :destroy
  has_one :website, dependent: :destroy
  has_many :phone_numbers, dependent: :destroy
  has_many :emails, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :time_slots, dependent: :destroy
  has_and_belongs_to_many :keywords

  attr_reader :keywords_sentence

  accepts_nested_attributes_for :address, :images, allow_destroy: true

  accepts_nested_attributes_for :time_slots, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:days].nil? || attributes[:days].empty? }

  accepts_nested_attributes_for :emails, :website, :phone_numbers, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:info].blank? }

  validates :name, presence: true

  validates :year_of_establishment, numericality: { only_integer: true, greater_than: 0, less_than: 9999 }, allow_blank: true

  include Workflow
  workflow do
    state :new do
      event :verifing, :transitions_to => :in_verification
    end
    state :in_verification do
      event :accepted, transitions_to: :verified
      event :rejected, transitions_to: :rejected
    end
    state :verified do
      event :publish, transitions_to: :published
    end
    state :published do
      event :unpublish, transitions_to: :unpublished
    end
    state :unpublished do
      event :publish, transitions_to: :published
      event :rejected, transitions_to: :rejected
      event :reverify, transitions_to: :in_verification
    end
    state :rejected do
      event :reverify, transitions_to: :in_verification
    end
  end

  def keywords_sentence=(sentence)
    self.keywords = sentence.split(',').map { |keyword| Keyword.find_or_create_by(name: keyword.strip) } if sentence
  end

  def setup(step_no: 1)
    case step_no
    when 1
      build_address unless address
    when 2
      phone_numbers.build unless phone_numbers.exists?
      emails.build unless emails.exists?
      build_website unless website
    when 3
      time_slots.build unless time_slots.exists?
      images.build unless images.exists?
      keywords.build unless keywords.exists?
    end
  end

  def set_status(status)
    ## FIXME_NISH Please do as discussed
    self.status = status == 'true'
    save
  end

end
