class Category < ActiveRecord::Base

  before_create :set_position

  has_attached_file :image, styles: { thumb: '80x80>' },
      :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
      :path => "public/system/:class/:attachment/:id/:style/:basename.:extension"

  validates :name, presence: true
  validates :name, uniqueness: true, allow_blank: true
  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  private

  def set_position
    self.position = (Category.minimum(:position) || 0) - 1
  end

end
