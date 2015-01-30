class PhoneNumber < Contact

  validates :pin_code, format: /\A\d+\z/

end
