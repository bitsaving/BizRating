class PhoneNumber < Contact

  validates :info, format: /\A\d+\z/, allow_blank: true

end
