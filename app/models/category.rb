class Category < ActiveRecord::Base

  # has_attached_file :image, styles: { thumb: "80x80" },
  # path: ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
  # url: ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
  #   :whiny_thumbnails => true

  has_attached_file :image, {
    styles: { detail: '330>', list: '169>' },
    default_url: '/assets/missing_product.png'
  }.merge(PAPERCLIP_STORAGE_OPTIONS)

  validates :name, presence: true
  validates :name, uniqueness: true, allow_blank: true
  validates_attachment :image,
   content_type: { content_type: ["image/jpg",
    "image/jpeg", "image/png", "image/gif"] }

end
