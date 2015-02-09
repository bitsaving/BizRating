class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authorised_admin!

  def authorised_admin!
    #FIXME_AB: You can use unless here instead of if. But should not use unless when you have else statement.
    ## FIXME_NISH Please remove authentication part from this before_action.
    if !(user_signed_in? && current_user.admin?)
      redirect_to new_user_session_path
    end
  end

end
