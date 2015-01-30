class Category < ActiveRecord::Base

  has_many :business

  has_attached_file :image, styles: { thumb: '80x80>' },
      url: "/system/:class/:attachment/:id/:style/:basename.:extension"

  ## FIXME_NISH Please add a validation of presence of position.
  ## FIXED
  validates :name, :position, presence: true
  validates :name, :position, uniqueness: true, allow_blank: true

  ## FIXME_ME Please add image size in the validations.
  ##FIXED
  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { less_than: 2.megabyte }

  ## FIXME_NISH Please run this validation only on create.
  ##FIXED
  before_validation :set_position, on: :create

  def set_status(status)
    ## FIXME_NISH Move this to model.
    ## FIXED
    self.status = status == 'true' ? false : true
    save
  end

  private

  def set_position
    self.position = (Category.minimum(:position) || 0) - 1
  end


end
