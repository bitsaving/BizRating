class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable

  has_and_belongs_to_many :roles

  validates :first_name, presence: true

  def roles_name_array
    roles.pluck(:name)
  end

  def admin?
    roles_name_array.include? 'admin'
  end

end
