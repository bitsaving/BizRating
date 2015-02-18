class PhoneNumber < Contact

  PHONE_NUMBER_REGEX = /\A\d+\z/

  validates :info, format: { with: PHONE_NUMBER_REGEX, message: 'is not a phone number' }, allow_blank: true

end
