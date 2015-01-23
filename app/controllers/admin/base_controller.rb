class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authorised_admin!

end
