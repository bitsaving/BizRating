class PhoneNumber < Contact

  validates :info, format: /\A\d+\z/

end
