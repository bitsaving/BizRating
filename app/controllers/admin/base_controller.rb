class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authorised_admin!

  def authorised_admin!
    if !(user_signed_in? && current_user.admin?)
      redirect_to new_user_session_path
    end
  end

end
