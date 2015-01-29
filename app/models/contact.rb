## FIXME_NISH Add validation for details.
## FIXME_NISH Rename columns details.
## FIXED
class Contact < ActiveRecord::Base

  belongs_to :business, required: true

  validates :info, presence: true

end