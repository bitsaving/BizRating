class Keyword < ActiveRecord::Base

  validates :name, presence: true
  validates :name, uniqueness: true, allow_blank: true

  has_and_belongs_to_many :businesses

end
