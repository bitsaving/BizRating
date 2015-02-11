#FIXME_AB: Almost all tables are missing db indexes. You should always add indexes to required columns.
class Address < ActiveRecord::Base

  belongs_to :business

  validates :city, :country, :state, :pin_code, presence: true

  #FIXME_AB: Do not place extra lines between validations. just need to separate associations validations etc.

  ## FIXME_NISH Move this Regex in a constants.
  validates :pin_code, format: { with: /\A\d+\z/ }, allow_blank: true


  def full_address
    [city, state, country].join(', ')
  end

end
