class HomeController < ApplicationController

  def index
    @category = Category.order(:position).enabled
  end

end