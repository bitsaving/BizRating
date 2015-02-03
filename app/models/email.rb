class Email < Contact

  validates :info, format: Devise.email_regexp, allow_blank: true

end
