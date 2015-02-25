class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :confirmable

  has_and_belongs_to_many :roles
  has_many :reviews

  validates :name, presence: true
  validates :active, inclusion: [true, false]

  #FIXME_AB: should be named as has_role?(:admin), since it is checking inclusion
  def admin?
    roles_names.include? 'admin'
  end

  def active_for_authentication?
    super and is_active?
  end

  def inactive_message
    is_active? ? super : 'Your account has been disabled. Please contact with Bizrating Admin.'
  end

  def set_status!(status)
    update(active: (status == 'true'))
  end

  private

    def is_active?
      active
    end

    def roles_names
      roles.pluck(:name)
    end

end
