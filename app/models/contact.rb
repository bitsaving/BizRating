## FIXME_NISH Add validation for details.
## FIXME_NISH Rename columns details.
class Contact < ActiveRecord::Base

  belongs_to :business, required: true

  validates :details, presence: true

end