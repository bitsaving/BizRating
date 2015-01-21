class Category < ActiveRecord::Base

  has_attached_file :image, {
    styles: { thumb: '80x80>' },
    default_url: '/assets/missing_product.png'
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  validates :name, presence: true
  validates :name, uniqueness: true, allow_blank: true
  validates_attachment :image, presence: true,
   content_type: { content_type: ["image/jpg",
    "image/jpeg", "image/png", "image/gif"] }

end
