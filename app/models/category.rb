class Category < ActiveRecord::Base

  has_many :business

  has_attached_file :image, styles: { thumb: '80x80>' },
      url: "/system/:class/:attachment/:id/:style/:basename.:extension"

  validates :name, :position, presence: true
  validates :name, :position, uniqueness: true, allow_blank: true

  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { less_than: 2.megabyte }

  before_validation :set_position, on: :create

  def set_status(status)
    ## FIXME_NISH Fix this.
    ## FIXED
    self.status = (status == 'true')
    save
  end

  private

  def set_position
    self.position = (Category.minimum(:position) || 0) - 1
  end

end
