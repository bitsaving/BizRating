class Email < Contact

  validates :details, format: Devise.email_regexp, allow_blank: true

end
