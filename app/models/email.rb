class Email < Contact

  validates :info, format: {with: Devise.email_regexp, message: 'is not a email type'}, allow_blank: true

end
