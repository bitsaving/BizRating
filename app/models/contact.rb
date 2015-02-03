class Contact < ActiveRecord::Base

  belongs_to :business, required: true

  validates :info, presence: true

end
