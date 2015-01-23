class Category < ActiveRecord::Base

  ## FIXME_NISH Use new syntax of hash.
  has_attached_file :image, styles: { thumb: '80x80>' },
      :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
      :path => "public/system/:class/:attachment/:id/:style/:basename.:extension"

  ## FIXME_NISH Please add a validation of presence of position.
  validates :name, presence: true
  validates :name, uniqueness: true, allow_blank: true

  ## FIXME_ME Please add image size in the validations.
  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  before_create :set_position

  private

  def set_position
    self.position = (Category.minimum(:position) || 0) - 1
  end

end
