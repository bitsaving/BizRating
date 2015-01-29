class Business < ActiveRecord::Base

  belongs_to :category

  has_one :address
  has_one :website
  has_many :phone_numbers
  has_many :emails
  has_many :images
  has_many :timmings

  has_and_belongs_to_many :keywords

  accepts_nested_attributes_for :address, :emails, :phone_numbers, :images, :website, :timmings, allow_destroy: true

  accepts_nested_attributes_for :keywords, allow_destroy: true,
     reject_if: proc { |attributes| attributes['name'].blank? }

  validates :name, presence: true

  def normalize_business_keywords
    self.keywords = keywords.to_a.map do |keyword|
      Keyword.where(name: keyword.name).exists? ? Keyword.find_by(name: keyword.name) : keyword
    end
  end

  def update(new_attributes)
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
