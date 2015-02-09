class Address < ActiveRecord::Base

  belongs_to :business

  validates :city, :country, :state, :pin_code, presence: true

  ## FIXME_NISH Move this Regex in a constants.
  validates :pin_code, format: { with: /\A\d+\z/ }, allow_blank: true

end
