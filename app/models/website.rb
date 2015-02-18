class Website < Contact

#FIXME_AB: Should extract out all the regexp in a constant hash like RegExp[:url]. Lets do it all places
  ## FIXME_NISH Move this regex in a constant.
  ## FIXED
  validates :info, format: RegExp[:url], allow_blank: true

end
