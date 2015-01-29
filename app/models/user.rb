class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable

  has_and_belongs_to_many :roles

  validates :name, presence: true

  def roles_names
    roles.pluck(:name)
  end

  def admin?
    roles_names.include? 'admin'
  end

end
