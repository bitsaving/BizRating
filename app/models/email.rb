## Please add validation for email address.
## FIXED
class Email < Contact

  validates :details, format: Devise.email_regexp, allow_blank: true

end
>>>>>>> BR-6
