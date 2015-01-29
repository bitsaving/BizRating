class Image < ActiveRecord::Base

  belongs_to :business, required: true

  has_attached_file :image, styles: { thumb: '80x80>' },
     url: "/system/:class/:attachment/:id/:style/:basename.:extension",
      path: "public/system/:class/:attachment/:id/:style/:basename.:extension"

  validates_attachment :image,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { less_than: 2.megabyte }  
end
