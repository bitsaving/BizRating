#FIXME_AB: Almost all tables are missing db indexes. You should always add indexes to required columns.
class Address < ActiveRecord::Base

  PIN_CODE_REGEX = /\A\d+\z/

  belongs_to :business

  validates :city, :country, :state, :pin_code, presence: true
  validates :pin_code, format: { with: PIN_CODE_REGEX, message: 'is not a zip code' }, allow_blank: true

  #FIXME_AB: Do not place extra lines between validations. just need to separate associations validations etc.
  ## FIXED
  ## FIXME_NISH Move this Regex in a constants.
  ## FIXED
end
