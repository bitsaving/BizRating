class Contact < ActiveRecord::Base

  belongs_to :business, required: true

  validates :details, presence: true

end