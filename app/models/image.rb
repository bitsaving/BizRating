class Image < ActiveRecord::Base

  belongs_to :business

  has_attached_file :image, url: "/system/:class/:attachment/:id/:style/:basename.:extension",
      path: "public/system/:class/:attachment/:id/:style/:basename.:extension"

  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { less_than: 2.megabyte }  
end
