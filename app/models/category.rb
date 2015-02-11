class Category < ActiveRecord::Base

  #FIXME_AB: What should we do when category got destroyed
  has_many :business

  #FIXME_AB: Do you know what > sign means in the thumbnail size? if not read more about it
  has_attached_file :image, styles: { thumb: '80x80>' },
      url: "/system/:class/:attachment/:id/:style/:basename.:extension"

  validates :name, :position, presence: true
  validates :name, :position, uniqueness: true, allow_blank: true

  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { less_than: 2.megabyte }

  before_validation :set_position, on: :create

  scope :enabled, -> { where status: true }

  #FIXME_AB: Actually these type of methods should be named as def status!(status). Thoughts?
  def set_status(status)
    self.status = (status == 'true')
    save
  end

  private

  #FIXME_AB: Method name does not reflect the purpose
  def set_position
    self.position = (Category.minimum(:position) || 0) - 1
  end

end
