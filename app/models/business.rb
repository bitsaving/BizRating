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


  accepts_nested_attributes_for :keywords, allow_destroy: true,
     reject_if: proc { |attributes| attributes[:name].blank? }

  validates :name, presence: true

  validates :year_of_establishment, numericality: { only_integer: true, greater_than: 0, less_than: 9999 }

  def normalize_business_keywords
    ## FIXME_NISH Use find_or_create_by
    self.keywords = keywords.to_a.map do |keyword|
      Keyword.where(name: keyword.name).exists? ? Keyword.find_by(name: keyword.name) : keyword
    end
  end

  def update(new_attributes)
    ## FIXME_NISH Please don't override update. Instead create a method for keywords like keywords_sentence=.
    new_attributes[:keywords_attributes].each do |key, value|
      if ((!value.has_key? :id) && Keyword.where(name: value[:name]).exists?)
        keyword = Keyword.find_by(name: value[:name])
        keywords << keyword
        value[:id] = keyword.id
      end
    end
    super(new_attributes)
  end




end
