class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  VALID_ROLES = ['user', 'admin']

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, inclusion: {in: VALID_ROLES}, allow_blank: true
end
