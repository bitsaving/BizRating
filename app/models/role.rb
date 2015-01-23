class Role < ActiveRecord::Base

  has_and_belongs_to_many :users

  VALID_NAMES = ['user', 'admin']

  validates :name, presence: true
  validates :name, uniqueness: true, inclusion: { in: VALID_NAMES }, allow_blank: true

end
