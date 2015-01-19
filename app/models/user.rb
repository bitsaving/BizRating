class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_and_belongs_to_many :roles

  validates :first_name, presence: true
  validates_presence_of :address, :state,
                        :pin_code, :phone_number,
                        if: "roles.where(name: 'admin').exists?"

  def role
    roles.pluck(:name)
  end

  def is_admin?
    role.include? 'admin'
  end

  # def add_roles(*new_roles)
  #   new_roles.each { |role| roles << Role.find_by(name: role) }
  # end

end
