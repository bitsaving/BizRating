## Please add validation for email address.
## FIXED
class Email < Contact

  validates :info, format: Devise.email_regexp, allow_blank: true

end
