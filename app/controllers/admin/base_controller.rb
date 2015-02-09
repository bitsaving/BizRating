class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authorised_admin!

  def authorised_admin!
    ## FIXME_NISH Please remove authentication part from this before_action.
    if !(user_signed_in? && current_user.admin?)
      redirect_to new_user_session_path
    end
  end

end
