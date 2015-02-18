class Category < ActiveRecord::Base

  #FIXME_AB: What should we do when category got destroyed
  has_many :businesses

  #FIXME_AB: Do you know what > sign means in the thumbnail size? if not read more about it
  has_attached_file :image, styles: { thumb: '80x80' },
      url: "/system/:class/:attachment/:id/:style/:basename.:extension"

  validates :name, :position, presence: true
  validates :name, :position, uniqueness: true, allow_blank: true

  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { less_than: 2.megabytes }

  before_validation :set_initial_position, on: :create

  scope :enabled, -> { where status: true }
  scope :live, -> { enabled.with_published_state }

  #FIXME_AB: Actually these type of methods should be named as def status!(status). Thoughts?
  ## FIXED
  def set_status!(status)
    ## FIXME_NISH Fix this.
    ## FIXED
    update(status: (status == 'true'))
  end

  private

  #FIXME_AB: Method name does not reflect the purpose
  ## FIXED
  def set_initial_position
    self.position = (Category.minimum(:position) || 0) - 1
  end

end
