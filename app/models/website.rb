class Website < Contact

#FIXME_AB: Should extract out all the regexp in a constant hash like RegExp[:url]. Lets do it all places
  ## FIXME_NISH Move this regex in a constant.
  validates :info, format: /\A(https?:\/\/)?(www\.)?([A-Z0-9._%+-])+(\.[A-Z]{2,4}){1,2}\z/i, allow_blank: true

end
